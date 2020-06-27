//
//  MovieDetailVC.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieDetailVC: UIViewController {
    
    let movieDetailService = MovieDetailService()
    var movieDetailData: MovieDetailModel!
    var identifier: String!
    
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        fetchMovieDetail()
        print(identifier)
    }
    
    func fetchMovieDetail() {
        
        movieDetailService.getMovieDetail(id: identifier) { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.movieDetailData = response
                DispatchQueue.main.async {
                    self.movieDetailTableView.reloadData()
                    print("***************************\(response)*************************" ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
        
//        detailMovieService.getMovieDetail(id: identifier){ [weak self](result) in
//            guard let self = self else {return}
//            switch result {
//            case .success(let response):
//                self.detailMovieData = response
//                DispatchQueue.main.async {
//                    self.movieDetailTableView.reloadData()
//                    print(response ?? "")
//                }
//            case .failure(let error):
//                print("*************************\(error)*******************************")
//            }
//        }
    }
    
    func setDelegates() {
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.register(MovieDetailTableViewCell.self)
    }

}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieDetailData != nil {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillMovieDetail(movieDetailResponse: movieDetailData)
        cell.movieDetailResponse = self.movieDetailData
        return cell
    }
}
