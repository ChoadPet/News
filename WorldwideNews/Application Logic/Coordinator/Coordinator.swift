//
//  Coordinator.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

protocol Coordinatable {
    
    func startFlow()
}

final class Coordinator: Coordinatable {
    
    private let window: UIWindow
    private let router: Routable
    
    init(window: UIWindow) {
        self.window = window
        self.router = Router(navigationController: NewsNavigationController())
    }
    
    // MARK: - Public API
    func startFlow() {
        let viewController = createNewsListViewController()
        router.initialViewControllers([viewController])
        
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
    
    func openNewsDetailViewController(model: NewsEntity) {
        let viewController = createNewsDetailViewController(model: model)
        router.push(viewController: viewController, animated: true)
    }
    
    // MARK: - Private API
    private func createNewsListViewController() -> NewsListTableViewController {
        let viewController = NewsListTableViewController.init(nibName: NewsListTableViewController.className, bundle: nil)
        let configurator = NewsListConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        return viewController
    }
    
    private func createNewsDetailViewController(model: NewsEntity) -> NewsDetailViewController {
        let viewController = NewsDetailViewController.init(nibName: NewsDetailViewController.className, bundle: nil)
        let configurator = NewsDetailConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, model: model)
        return viewController
    }
}
