//
//  NewsRefreshControl.swift
//  WorldwideNews
//
//  Created by pc251 on 04.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

final class NewsRefreshControl: UIRefreshControl {
    
    override init() {
        super.init()
        self.tintColor = UIColor.systemYellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
