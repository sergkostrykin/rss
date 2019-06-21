//
//  NSErrorExtension.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

extension NSError {
    class func standard(message: String?) -> NSError {
        return NSError(domain: "self", code: 0, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
}
