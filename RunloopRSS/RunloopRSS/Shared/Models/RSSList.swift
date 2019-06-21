//
//  MovieList.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

struct RSSList: Decodable {
    
    let page: Int?
    let title: String?
    let link: String?
    let description: String?
    let totalResults: Int?
    let totalPages: Int?
    let results: [RSSItem]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case title
        case description
        case link
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
