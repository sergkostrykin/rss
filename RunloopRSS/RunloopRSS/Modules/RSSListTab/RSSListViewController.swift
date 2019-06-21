//  
//  RSSListViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import FeedKit

protocol RSSListView: class {
    
    func showSpinner()
    func dismissSpinner()
    func showAlert(title: String?, message: String?)
    func refresh(feed: RSSFeed?)
    
}


final class RSSListViewController: UIViewController {
    
    // MARK: - Properties
    private var output: RSSListViewOutput?
    private var feed: RSSFeed?
    private var items: [RSSFeedItem] {
        return feed?.items ?? [RSSFeedItem]()
    }
    

    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var segmentBackgroundView: UIView!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    
    // MARK: - Actions
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        reload()
    }
    
    @objc func refreshPulled(_ sender: UIButton) {
        reload()
    }


    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cells: ["FeedItemTableViewCell"])
        segmentBackgroundView.layer.cornerRadius = 5
        reload()
    }
    
    private func reload() {
        let type = FeedType(rawValue: segmentedControl.selectedSegmentIndex) ?? .business
        output?.loadFeed(type: type)
    }
}

extension RSSListViewController {
    func attach(output: RSSListViewOutput) {
        self.output = output
    }
}

extension RSSListViewController: RSSListView {
    func showSpinner() {
        AppRouter.showHUD()
    }
    
    func dismissSpinner() {
        AppRouter.hideHUD()
    }
    
    func showAlert(title: String?, message: String?) {}
    
    func refresh(feed: RSSFeed?) {
        self.feed = feed
        tableView.reloadData()
    }

}

extension RSSListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemTableViewCell", for: indexPath) as? FeedItemTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.setup(item: item, image: feed?.image?.url, isSeparatorHidden: indexPath.row == items.count - 1)
        return cell

    }
}

extension RSSListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
