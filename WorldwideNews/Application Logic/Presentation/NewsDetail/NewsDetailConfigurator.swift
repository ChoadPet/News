//
//  NewsDetailConfigurator.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/8/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

final class NewsDetailConfigurator {
    func configure(viewController: NewsDetailViewController, coordinator: Coordinator, model: NewsEntity) {
        let presenter = NewsDetailPresenter(coordinator: coordinator, view: viewController, model: model)
        viewController.presenter = presenter
    }
}
