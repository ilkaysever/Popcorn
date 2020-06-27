//
//  MovieDetailService.swift
//  Popcorn
//
//  Created by ilkay sever on 27.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import Moya

class MovieDetailService {
    
    private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func getMovieDetail(id: String!, completion: @escaping (Result<MovieDetailModel, Error>) -> Void ){
        provider.request(.getMovieDetail(id: id)) { (response) in
            switch response {
            case .success(let data):
                do{
                    let movieDetailResponse = try JSONDecoder().decode(MovieDetailModel.self, from: data.data)
                    completion(.success(movieDetailResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
