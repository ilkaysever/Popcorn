//
//  MovieDetailModel.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import Foundation

struct MovieDetailModel: Codable {
    var title: String!
    var releaseData: String!
    var runTime: String!
    var genre: String!
    var plot: String!
    var poster: String!
    var imdbRating: String!
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case releaseData = "Released"
        case runTime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case imdbRating = "imdbRating"
        case poster = "Poster"
        
    }
}
