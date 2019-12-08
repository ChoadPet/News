//
//  DataTaskCreater.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/8/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

protocol DataTaskCreator {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: DataTaskCreator {
    
}
