//
//  NewsListPresenter.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

final class NewsListPresenter {
    
    private let coordinator: Coordinator
    private weak var view: NewsListViewProtocol?
    private let networkManager: NetworkManager
    private let storageManager: PersistenceStorage
    
    private let paginationModel: PaginationEntity
    
    private(set) var dataSource: [NewsEntity] = [] {
        didSet {
            DispatchQueue.main.async(execute: self.view!.updateData)
        }
    }
    
    init(coordinator: Coordinator,
         view: NewsListViewProtocol,
         networkManager: NetworkManager,
         persistenceStorageManager: PersistenceStorage) {
        
        self.coordinator = coordinator
        self.view = view
        self.networkManager = networkManager
        self.storageManager = persistenceStorageManager
        self.paginationModel = PaginationEntity(pageSize: 10, page: 1)
        
        refreshData()
    }
    
    // MARK: - Public API
    func viewDidLoad() {
        view?.initTableView()
        view?.initNavigation()
    }
    
    /// Used for refresh data when user used pull to refresh
    func refreshData() {
        paginationModel.page = 1
        paginationModel.ended = false
        
        if networkManager.reachability.isReachable() {
            requestNews { [weak self] news in
                self?.dataSource.removeAll()
                self?.dataSource.append(contentsOf: news)
            }
        }
    }
    
    /// Used for request next page of data, when we scroll to last element
    func requestMoreData() {
        if !networkManager.reachability.isReachable() { return }
        
        requestNews { [weak self] news in
            self?.dataSource.append(contentsOf: news)
            self?.write(news: news)
        }
    }
    
    func didSelectNewsAt(_ index: Int) {
        let model = dataSource[index]
        coordinator.openNewsDetailViewController(model: model)
    }
    
    // MARK: - Private API
    private func requestNews(completion: @escaping (([NewsEntity]) -> Void)) {
        let model = ArticleInput(pageSize: paginationModel.pageSize, page: paginationModel.page, language: Locale.current.languageCode ?? "en", keywordsOrPhrase: "dogs")
        
        if paginationModel.canMakeRequestForNextPage {
            paginationModel.updateState = .processing
            networkManager.provideEverythingNews(model: model) { [weak self] response in
                guard let self = self else { return }
                self.paginationModel.updateState = .completed
                guard let result = response, let articles = result.articles else {
                    self.paginationModel.ended = true
                    return completion([])
                }
                
                self.paginationModel.didReachEnd(totalResult: result.totalResults!)
                self.paginationModel.incrementPage()
                
                completion(articles)
            }
        }
    }
    
    private func write(news: [NewsEntity]) {
        DispatchQueue.main.async {
            self.storageManager.write(sequence: news)
        }
    }
    
    private func clearCache() {
        DispatchQueue.main.async {
            self.storageManager.removeObjectsOfType(NewsEntity.self)
        }
    }
    
    private func getCachedNews() -> [NewsEntity] {
        return self.storageManager.getObjects(withPredicate: nil)
    }
}

protocol NewsListViewProtocol: class, TableViewInitializer, NavigationInitializer {
    func updateData()
}
