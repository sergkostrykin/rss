//
//  DateTimeTools.swift
//  Qorum
//
//  Created by Stanislav on 19.12.2017.
//  Copyright © 2017 Bizico. All rights reserved.
//

import UIKit

extension Date {
    
    
    /// Returns Date Formatter for date in format MM/dd/yyyy
    static let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    /// Returns Date Formatter for date in format MM dd yyyy
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
    var releaseDateString: String {
        return Date.releaseDateFormatter.string(from: self)
    }

}
