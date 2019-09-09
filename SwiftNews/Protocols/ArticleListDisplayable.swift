//
//  ArticleListDisplayable.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/8/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

protocol ArticleListDisplayable {
    var articleTitle: String? { get }
    var imageURL: URL? { get }
    var articleDesc: String? { get }
}
