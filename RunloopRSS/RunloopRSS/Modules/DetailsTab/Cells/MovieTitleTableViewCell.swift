//
//  MovieTitleTableViewCell.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/20/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

class MovieTitleTableViewCell: UITableViewCell {

    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieOverviewLabel: UILabel!
    @IBOutlet private var ratingView: UIView!
    @IBOutlet private var likedLabel: UILabel!
    @IBOutlet private var releaseLabel: UILabel!
    @IBOutlet private var likedLabelViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var likedLabelRatingLeadingConstraint: NSLayoutConstraint!

    
    
    func setup(movie: RSSItem?) {
        
        movieTitleLabel.text = movie?.title
        let popularity = movie?.popularity ?? 0.0
        let voteAverage = movie?.voteAverage ?? 0.0
        if voteAverage == 0.0 {
            ratingView.isHidden = true
            likedLabelViewLeadingConstraint.isActive = true
            likedLabel.text = "\(Int(popularity))% liked this movie"
        } else {
            ratingView.isHidden = false
            likedLabelViewLeadingConstraint.isActive = false
            likedLabel.text = "\(voteAverage) | \(Int(popularity))% liked this movie"
        }
        
        likedLabelRatingLeadingConstraint.isActive = !likedLabelViewLeadingConstraint.isActive
        let releaseDate = movie?.releaseDate?.apiDate?.releaseDateString ?? ""
        releaseLabel.text = "In theatres \(releaseDate)"
        movieOverviewLabel.text = movie?.overview
    }

}
