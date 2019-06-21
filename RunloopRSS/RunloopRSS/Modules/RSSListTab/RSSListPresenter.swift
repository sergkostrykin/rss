//  
//  RSSListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

enum FeedType: Int {
    case business = 0
    case entertainment = 1
}


protocol RSSListViewOutput: class {
    func loadFeed(type: FeedType)
    func showDetails(movie: RSSItem)
}

final class RSSListPresenter {
    
    private var router: RSSListRouter?
    
    private weak var view: RSSListView?
    
}

extension RSSListPresenter: RSSListViewOutput {
    

    func loadFeed(type: FeedType) {
        view?.showSpinner()
        URNNetworking.fetchRSSFeed(type: type) { [weak self] (feed, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                self?.view?.refresh(feed: feed)
            }
        }
    }

    func showDetails(movie: RSSItem) {
        router?.showDetails(movie: movie)
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
