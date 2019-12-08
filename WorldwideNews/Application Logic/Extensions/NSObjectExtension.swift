//
//  NSObjectExtension.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
