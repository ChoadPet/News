//
//  ArticleOutput.swift
//  WorldwideNews
//
//  Created by pc251 on 04.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import RealmSwift

struct ArticleOutput: Decodable {
    let status: ResponseStatus
    let code: String?
    let message: String?
    let totalResults: Int?
    let articles: [NewsEntity]?
}

enum ResponseStatus: String, Decodable {
    case ok
    case error
}

final class NewsSource: Object, Decodable {
    let id: String?
    let name: String?
}
