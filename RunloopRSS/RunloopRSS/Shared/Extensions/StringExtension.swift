//
//  StringExtensions.swift
//  Enterprise
//
//  Created by Jens Borghardt on 11/22/16.
//  Copyright © 2016 Jens Borghardt. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    var asURL: URL? {
        return URL(string: self)
    }
    
    var apiDate: Date? {
        return Date.apiDateFormatter.date(from: self)
    }

}

