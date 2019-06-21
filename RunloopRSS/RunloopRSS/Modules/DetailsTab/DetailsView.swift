//  
//  DetailsView.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

protocol DetailsView: class {
    
    func refresh(movie: RSSItem?)
    
    func showAlert(title: String?, message: String?)

    func showSpinner()

    func dismissSpinner()
}
