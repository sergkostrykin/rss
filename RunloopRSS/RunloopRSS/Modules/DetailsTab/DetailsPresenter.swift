//  
//  DetailsPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import FeedKit

protocol DetailsViewOutput: class {
    func didLoad()
    func back()
    func startPeriodicalUpdate()
    func stopPeriodicalUpdate()
}

final class DetailsPresenter {

    var movie: RSSItem?
    private let kPeriodicalUdpateTimeInterval: TimeInterval = 1
    private var router: DetailsRouter?
    private weak var view: DetailsView?
    private var timer: Timer?
    
    
    init(movie: RSSItem?) {
        self.movie = movie
    }
    
    func startPeriodicalUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: kPeriodicalUdpateTimeInterval, repeats: true, block: { [weak self] (timer) in
            self?.view?.refreshTimeLabel()
        })
    }
    
    func stopPeriodicalUpdate() {
        timer?.invalidate()
        timer = nil
    }
    
    func reload(rssItem: RSSFeedItem) {
        view?.refresh(feedItem: rssItem)
    }
    
    func loadDetails() {
    }

}

extension DetailsPresenter: DetailsViewOutput {
    func didLoad() {
        print(#function)
        loadDetails()
    }
    
    func back() {
        router?.routeBack()
    }
}

extension DetailsPresenter {
    func attach(router: DetailsRouter) {
        self.router = router
    }
    
    func attach(view: DetailsView) {
        self.view = view
    }
}
