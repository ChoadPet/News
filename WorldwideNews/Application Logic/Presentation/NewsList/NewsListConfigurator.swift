//
//  NewsListConfigurator.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/8/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

final class NewsListConfigurator {
    func configure(viewController: NewsListTableViewController, coordinator: Coordinator) {
        let requestManager = RequestManager<NewsAPI>()
        let reachability = Reachability()
        let networkManager = NetworkManager(requestManager: requestManager, reachability: reachability)
        let storageManager = PersistenceStorage<NewsEntity>()
        let presenter = NewsListPresenter(coordinator: coordinator,
                                          view: viewController,
                                          networkManager: networkManager,
                                          persistenceStorageManager: storageManager)
        viewController.presenter = presenter
    }
}
