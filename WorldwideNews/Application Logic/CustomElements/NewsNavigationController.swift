//
//  NewsNavigationController.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

class NewsNavigationController: UINavigationController {
    
    private var largeTitleViewControllers: [UIViewController.Type] {
        return [NewsListTableViewController.self]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
}

extension NewsNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if largeTitleViewControllers.contains(where: { $0 == type(of: viewController) }) {
            navigationController.navigationBar.prefersLargeTitles = true
            viewController.navigationItem.largeTitleDisplayMode = .always
        } else {
            viewController.navigationItem.largeTitleDisplayMode = .never
        }
    }
}
