//  
//  DetailsPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
//import URNNetworking

protocol DetailsViewOutput: class {
    func didLoad()
    func back()
}

final class DetailsPresenter {
    private var router: DetailsRouter?
    private weak var view: DetailsView?
    
    var movie: RSSItem?
    
    
    init(movie: RSSItem?) {
        self.movie = movie
    }
    

    func loadDetails() {
//        guard let id = movie?.id else { return }
//        view?.showSpinner()
//        URNNetworking.fetchPhotos { [weak self] (json, error) in
//            DispatchQueue.main.async {
//                self?.view?.dismissSpinner()
//                if let error = error {
//                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
//                    return
//                }
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
//                    let movie = try JSONDecoder().decode(Movie?.self, from: jsonData)
//                    self?.view?.refresh(movie: movie)
//                } catch {
//                    DispatchQueue.main.async {
//                       self?.view?.showAlert(title: "Error", message: error.localizedDescription)
//                    }
//                    print(error)
//                }
//            }
//        }
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
