//
//  MovieDetailTableViewCell.swift
//  Popcorn
//
//  Created by ilkay sever on 27.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    var movieDetailResponse: MovieDetailModel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var imdbRateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Fill Movie Detail List
    func fillMovieDetail(movieDetailResponse: MovieDetailModel) {
        let imgUrl = URL(string: movieDetailResponse.poster ?? "")
        moviePoster.kf.setImage(with: imgUrl, placeholder: UIImage(named: "default"))
        movieNameLabel.text = movieDetailResponse.title
        releaseDateLabel.text = movieDetailResponse.releaseData
        genreLabel.text = movieDetailResponse.genre
        runTimeLabel.text = movieDetailResponse.runTime
        imdbRateLabel.text = movieDetailResponse.imdbRating
        descriptionLabel.text = movieDetailResponse.plot
    }
    
}

