//
//  GetSwiftNewsResponse.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

struct GetSwiftNewsResponse: Codable {
    var kind: String?
    var data: BaseData?
}

struct BaseData: Codable {
    var modhash: String?
    var dist: Int?
    var articles: [Article]?
    var after: String?
    var before: String?
    
    private enum CodingKeys : String, CodingKey {
        case articles = "children"
    }
}

struct Article: Codable {
    var kind: String?
    var data: ArticleData?
}

struct ArticleData: Codable {
    //.. parsing only required items
    var title: String?
    var thumbnailURLString: String?
    var description: String?
    //..
    
    private enum CodingKeys : String, CodingKey {
        case title = "title"
        case thumbnailURLString = "thumbnail"
        case description = "selftext"
    }
}

extension ArticleData: ArticleListDisplayable {
    
    var articleTitle: String? {        
        return title
    }
    
    var articleDesc: String? {
        // You can modify text attributes and send attributedText instead
        return description
    }
    
    var imageURL: URL? {
        guard let imageURLString = thumbnailURLString else { return nil }
        return URL(string: imageURLString)
    }
}
