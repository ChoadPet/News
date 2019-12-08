//
//  Router.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/8/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

protocol Routable {
    var navigationController: NewsNavigationController { get }
    
    func initialViewControllers(_ viewControllers: [UIViewController])
    func push(viewController: UIViewController, animated: Bool)
}

final class Router: Routable {
    let navigationController: NewsNavigationController
    
    init(navigationController: NewsNavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewControllers(_ viewControllers: [UIViewController]) {
        navigationController.viewControllers = viewControllers
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}
