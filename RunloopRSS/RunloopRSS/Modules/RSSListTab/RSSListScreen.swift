//  
//  RSSListScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol RSSListRouter {
    func showDetails(movie: RSSItem)
}

final class RSSListScreen {
    private weak var viewController: RSSListViewController?
    private weak var presenter: RSSListPresenter?
    
    func instantiateViewController() -> RSSListViewController {
        guard let viewController = UIStoryboard(name: "RSSList", bundle: nil).instantiateViewController(withIdentifier: "RSSListViewController") as? RSSListViewController else { fatalError("Failed to load RSSListViewСontroller") }
    
        let presenter = RSSListPresenter()
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
}

extension RSSListScreen: RSSListRouter {
    
    func showDetails(movie: RSSItem) {
        DetailsScreen().push(to: viewController?.navigationController)
    }

}
