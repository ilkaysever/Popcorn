//
//  API.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import Moya

public enum API {
    
    case getSearch(search: String, page: Int)
    case getMovieDetail(id: String)
    
}

extension API: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://omdbapi.com")!
    }
    
    public var path: String {
        switch self {
        case .getSearch:
            return ""
        case .getMovieDetail:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getSearch:
            return .get
        case .getMovieDetail:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getSearch(let search, let page):
            return .requestParameters(parameters: ["s": search, "page": page, "apikey": "682d8365"], encoding: URLEncoding.default)
        case .getMovieDetail(let id):
            return .requestParameters(parameters: ["i": id, "apikey": "682d8365"], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .getSearch:
            return nil
        case .getMovieDetail:
            return nil
        }
    }
}


