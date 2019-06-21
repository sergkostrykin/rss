//
//  RSSItem
//  RSSItem
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//
import Foundation

struct RSSItem: Decodable {
    
    let id: Int?
    let title: String?
    let link: String?
    let description: String?
    
    
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let releaseDate: String?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
        case description
        
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case popularity
    }
}
