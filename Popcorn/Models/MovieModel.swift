//
//  MovieModel.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import Foundation

struct MoviesArray: Codable {
    
    var search: [MovieModel]!
    var totalResults: String!
    var response: String!
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
        case totalResults
    }

}

struct MovieModel: Codable {
    
    var title: String!
    var year: String!
    var imdbID: String!
    var type: String!
    var poster: String!
    
    enum CodingKeys: String, CodingKey {
        case title    = "Title"
        case year     = "Year"
        case imdbID   = "imdbID"
        case type     = "Type"
        case poster   = "Poster"
    }
    
}
