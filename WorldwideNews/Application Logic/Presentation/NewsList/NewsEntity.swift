//
//  NewsEntity.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import RealmSwift

final class NewsEntity: Object, Decodable {
    @objc dynamic var articleID = UUID().uuidString
    @objc dynamic var author: String?
    @objc dynamic var content: String?
    @objc dynamic var articleDescription: String
    @objc dynamic var publishedAt: String?
    @objc dynamic var source: NewsSource?
    @objc dynamic var title: String?
    @objc dynamic var urlToImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case author
        case content
        case articleDescription = "description"
        case publishedAt
        case source
        case title
        case urlToImage
    }
    
    override class func primaryKey() -> String? {
        return "articleID"
    }
}
