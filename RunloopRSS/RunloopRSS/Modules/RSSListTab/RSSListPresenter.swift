//  
//  RSSListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import FeedKit

enum FeedType: Int {
    case business = 0
    case entertainment = 1
}


protocol RSSListViewOutput: class {
    func loadFeed(type: FeedType, animated: Bool)
    func showDetails(rssItem: RSSFeedItem)
    func startPeriodicalUpdate()
    func stopPeriodicalUpdate()
    
}

final class RSSListPresenter {
    private let kPeriodicalUdpateTimeInterval: TimeInterval = 3
    private var router: RSSListRouter?
    private weak var view: RSSListView?
    private var timer: Timer?
    private var feedType: FeedType = .business
    private var isUpdating: Bool = false
    
}

extension RSSListPresenter: RSSListViewOutput {
    

    func loadFeed(type: FeedType, animated: Bool) {
        guard !isUpdating else { return }
        isUpdating = true
        self.feedType = type
        if animated {
            view?.showSpinner()
        }
        URNNetworking.fetchRSSFeed(type: type) { [weak self] (feed, error) in
            DispatchQueue.main.async {
                self?.isUpdating = false
                if animated {
                    self?.view?.dismissSpinner()
                }
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                self?.view?.refresh(feed: feed)
            }
        }
    }

    func showDetails(rssItem: RSSFeedItem) {
        router?.showDetails(rssItem: rssItem)
    }
    
    func startPeriodicalUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: kPeriodicalUdpateTimeInterval, repeats: true, block: { [weak self] (timer) in
            self?.loadFeed(type: self?.feedType ?? .business, animated: false)
        })
    }
    
    func stopPeriodicalUpdate() {
        timer?.invalidate()
        timer = nil
    }

}

extension RSSListPresenter {
    func attach(router: RSSListRouter) {
        self.router = router
    }
    
    func attach(view: RSSListView) {
        self.view = view
    }
}
