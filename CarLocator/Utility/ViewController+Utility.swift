//
//  ViewController+Utility.swift
//  CarLocator
//
//  Created by Amitabha Saha on 26/09/21.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgressBar() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideProgressBar() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
