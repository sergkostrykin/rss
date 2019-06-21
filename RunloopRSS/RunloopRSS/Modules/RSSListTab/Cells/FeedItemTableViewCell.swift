//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import Kingfisher
import FeedKit
class FeedItemTableViewCell: UITableViewCell {

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var releaseLabel: UILabel!
    @IBOutlet private var separator: UIView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var likedLabelViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var likedLabelRatingLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var linkTextView: UITextView!
    
    func setup(item: RSSFeedItem?, image: String? = nil,  isSeparatorHidden: Bool = false) {
        
        movieTitleLabel.text = item?.title
        let placeholder = UIImage(named: "placeholder")
        
        if let urlString = image {
            movieImageView.kf.setImage(with: urlString.asURL, placeholder: placeholder)
        } else {
            movieImageView.image = placeholder
        }
        linkTextView.text = item?.link
        let releaseDate = item?.pubDate?.releaseDateString ?? ""
        releaseLabel.text = "Published \(releaseDate)"
        descriptionLabel.text = item?.description
        separator.isHidden = isSeparatorHidden
    }
}
