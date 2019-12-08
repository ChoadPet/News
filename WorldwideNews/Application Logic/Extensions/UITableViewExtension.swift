//
//  UITableViewExtension.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib(with identifier: String) {
        let nib = UINib(nibName: identifier, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: identifier)
    }
}
