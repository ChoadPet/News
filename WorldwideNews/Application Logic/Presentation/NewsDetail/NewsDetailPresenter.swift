//
//  NewsDetailPresenter.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

struct NewsDetailPresenter {
    
    private let coordinator: Coordinator
    private weak var view: NewsDetailViewProtocol?
    private(set) var model: NewsEntity
    
    init(coordinator: Coordinator, view: NewsDetailViewProtocol, model: NewsEntity) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        view?.initTableView()
        view?.initNavigation()

        if let stringUrl = model.urlToImage, let url = URL(string: stringUrl) {
            view?.updateHeaderImageView(withURL: url)
        } // if not image, the default image from .xib file will be displayed
    }
}

protocol NewsDetailViewProtocol: class, TableViewInitializer, NavigationInitializer {
    func updateHeaderImageView(withURL url: URL)
}
