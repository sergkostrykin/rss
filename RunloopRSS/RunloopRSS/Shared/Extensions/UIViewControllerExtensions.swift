//
//  UIViewControllerExtensions.swift
//  Enterprise
//
//  Created by Jens Borghardt on 11/22/16.
//  Copyright © 2016 Jens Borghardt. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(error: Error, actions: [UIAlertAction]? = nil) {
        alert(title: "Error", message: error.localizedDescription, actions: actions)
    }
    
    func alert(title: String?, message: String? = nil, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        
        if presentedViewController != nil {
            if presentingViewController == nil {
                view.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        present(alert, animated: true, completion: nil)
    }
}
