//
//  NewsListTableViewController.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
        
    var presenter: NewsListPresenter!
    
    private let newsRefreshControl = NewsRefreshControl()
    private let identifier = NewsTableViewCell.className
    private let rowHeight: CGFloat = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }

    @objc func refreshNews(refreshControl: UIRefreshControl) {
        presenter.refreshData()
    }
}

// MARK: - Table view data source
extension NewsListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = presenter.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsTableViewCell
        cell.updateCell(with: object)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectNewsAt(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.dataSource.count - 1 {
            presenter.requestMoreData()
        }
    }
}

// MARK: - View protocol implementation
extension NewsListTableViewController: NewsListViewProtocol {
    func initTableView() {
        tableView.registerNib(with: identifier)
        
        newsRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.refreshControl = newsRefreshControl
        
        // Just to remove empty lines after last cell
        tableView.tableFooterView = UIView()
    }
    
    func initNavigation() {
        navigationItem.title = "News"
    }
    
    func updateData() {
        tableView.reloadData()
        newsRefreshControl.endRefreshing()
    }
}

