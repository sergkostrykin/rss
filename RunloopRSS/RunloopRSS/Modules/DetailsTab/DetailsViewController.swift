//  
//  DetailsViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import FeedKit

protocol DetailsView: class {
    
    func refresh(feedItem: RSSFeedItem?)
    func refreshTimeLabel()
    func showAlert(title: String?, message: String?)
    func showSpinner()
    func dismissSpinner()
}


final class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var output: DetailsViewOutput?
    private var movie: RSSItem?

    // MARK: - Outlets

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Actions
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTimeLabel()
        gradientView.setGradient()
        output?.startPeriodicalUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output?.stopPeriodicalUpdate()
    }
    
    private func reload() {
        gradientView.setGradient()
    }
}

extension DetailsViewController {
    func attach(output: DetailsViewOutput) {
        self.output = output
    }
}

extension DetailsViewController: DetailsView {
    
    func showAlert(title: String?, message: String?) {}
    func showSpinner() {}
    func dismissSpinner() {}

    func refresh(feedItem: RSSFeedItem?) {
        descriptionLabel.text = feedItem?.description
    }

    func refreshTimeLabel() {
        let date = Date()
        dateLabel.text = date.releaseDateString
        timeLabel.text = date.timeDateString
    }
}
