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
    private let storageManager: PersistenceStorage<NewsEntity>
    
    /// Pagination prorperties
    private let pageSize = 10
    private var page = 1
    private var updating = false
    private var ended = false
    
    private(set) var dataSource: [NewsEntity] = [] {
        didSet {
            DispatchQueue.main.async(execute: self.view!.updateData)
        }
    }
    
    init(coordinator: Coordinator,
         view: NewsListViewProtocol,
         networkManager: NetworkManager,
         persistenceStorageManager: PersistenceStorage<NewsEntity>) {
        
        self.coordinator = coordinator
        self.view = view
        self.networkManager = networkManager
        self.storageManager = persistenceStorageManager
        
        refreshData()
    }
    
    // MARK: - Public API
    func viewDidLoad() {
        view?.initTableView()
        view?.initNavigation()
    }
    
    /// Used for refresh data when user used pull to refresh
    func refreshData() {
        page = 1
        ended = false
        if networkManager.reachability.isReachable() {
            requestNews { [weak self] news in
                self?.dataSource.removeAll()
                self?.dataSource.append(contentsOf: news)
            }
        } else {
            
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
        let model = ArticleInput(pageSize: pageSize, page: page, language: Locale.current.languageCode ?? "en", keywordsOrPhrase: "apple")
        if !self.updating && !self.ended {
            self.updating = true
            networkManager.provideEverythingNews(model: model) { [weak self] response in
                guard let self = self else { return }
                guard let result = response else {
                    self.updating = false
                    return completion([])
                }
                
                // If current page more or equal to total pages
                // we don't need to make request anymore
                self.ended = self.page >= result.totalResults
                self.updating = false
                self.page += 1
                
                completion(result.articles ?? [])
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
