//
//  NewsDetailViewController.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerImageViewHeightConstraint: NSLayoutConstraint!
    
    private let identifier = BasicTextTableViewCell.className
    
    var presenter: NewsDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - Table view data source
extension NewsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BasicTextTableViewCell
        cell.updateCell(with: presenter.model)
        return cell
    }
}

// MARK: - UIScrollView delegate
extension NewsDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// For shrink image
        let imageDefaultHeight = headerImageViewHeightConstraint.constant
        let y = imageDefaultHeight - (scrollView.contentOffset.y + imageDefaultHeight)
        let height = min(max(y, 0), 400)
        headerImageViewHeightConstraint.constant = height
    }
}

// MARK: - View protocol implementation
extension NewsDetailViewController: NewsDetailViewProtocol {
    func initTableView() {
        tableView.registerNib(with: identifier)
        
        tableView.contentInset = UIEdgeInsets(top: headerImageViewHeightConstraint.constant, left: 0, bottom: 0, right: 0)
        
        // Just to remove empty lines after last cell
        tableView.tableFooterView = UIView()
    }
    
    func initNavigation() {
        navigationItem.title = "Article"
    }
    
    func updateHeaderImageView(withURL url: URL) {
        headerImageView.kf.setImage(with: url)
    }
}
