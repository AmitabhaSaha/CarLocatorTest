//
//  Application+Utility.swift
//  CarLocator
//
//  Created by Amitabha Saha on 27/09/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func getRootView() -> UIViewController? {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
}
