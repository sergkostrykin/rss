//  
//  DetailsViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var output: DetailsViewOutput?
    private var movie: RSSItem?

    // MARK: - Outlets

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions

    @IBAction func backButtonClicked(_ sender: UIButton) {
        output?.back()
    }
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cells: ["MovieTitleTableViewCell"])

        output?.didLoad()
    }
    
    private func reload() {
        tableView.reloadData()
        gradientView.setGradient()
        let placeholder = UIImage(named: "placeholder")
        if let urlString = movie?.posterPath {
//            let url = "\(Environment.imageUrl)\(urlString)"
//            posterImageView.kf.setImage(with: url.asURL, placeholder: placeholder)
        } else {
            posterImageView.image = placeholder
        }
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

    func refresh(movie: RSSItem?) {
        self.movie = movie
        reload()
    }
}

extension DetailsViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTitleTableViewCell", for: indexPath) as? MovieTitleTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(movie: movie)
        return cell
        
    }
}
