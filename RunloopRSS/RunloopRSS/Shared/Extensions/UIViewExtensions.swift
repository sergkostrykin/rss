//
//  UIViewExtensions.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/20/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

extension UIView {

    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.colorGrey.withAlphaComponent(0.0).cgColor, UIColor.colorGrey.cgColor]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }

}
