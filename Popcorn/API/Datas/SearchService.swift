//
//  SearchService.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import Moya

class SearchService {
    
    private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func getSearch(text: String, completion: @escaping (Result<MoviesArray, Error>) -> Void ){
        provider.request(.getSearch(search: text, page: 1)) { (response) in
            switch response {
            case .success(let data):
                do{
                    let movieResponse = try JSONDecoder().decode(MoviesArray.self, from: data.data)
                    completion(.success(movieResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
