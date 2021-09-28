//
//  String+Utility.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
