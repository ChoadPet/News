//
//  ArticleOutput.swift
//  WorldwideNews
//
//  Created by pc251 on 04.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import RealmSwift

struct ArticleOutput: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsEntity]?
}

final class NewsSource: Object, Decodable {
    let id: String?
    let name: String?
}
