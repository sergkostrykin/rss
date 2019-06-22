//  
//  DetailsScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import FeedKit

protocol DetailsRouter {
    func routeBack()
}

final class DetailsScreen {

    private weak var viewController: DetailsViewController?
    private weak var presenter: DetailsPresenter?
    private var movie: RSSItem?
    
    init() {
    }

    func instantiateViewController() -> DetailsViewController {
        guard let viewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { fatalError("Failed to load DetailsViewСontroller") }
    
        let presenter = DetailsPresenter(movie: movie)
        presenter.attach(router: self)
        presenter.attach(view: viewController)
        viewController.attach(output: presenter)
    
        self.presenter = presenter
        self.viewController = viewController
    
        return viewController
    }
    
    func push(to: UINavigationController?, animated: Bool = true) {
        to?.pushViewController(instantiateViewController(), animated: animated)
    }
    
    func reload(rssItem: RSSFeedItem) {
        presenter?.reload(rssItem: rssItem)
    }
    
}

extension DetailsScreen: DetailsRouter {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
