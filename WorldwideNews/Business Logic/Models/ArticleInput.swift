//
//  ArticleInput.swift
//  WorldwideNews
//
//  Created by pc251 on 04.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

struct ArticleInput: Encodable {
    let pageSize: Int
    let page: Int
    let language: String
    let keywordsOrPhrase: String
    
    private enum CodingKeys: String, CodingKey {
        case pageSize
        case page
        case language
        case keywordsOrPhrase = "q"
    }
}
