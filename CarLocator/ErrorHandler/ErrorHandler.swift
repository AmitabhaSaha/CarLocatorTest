//
//  ErrorCodes.swift
//  CarLocator
//
//  Created by Amitabha Saha on 26/09/21.
//

import Foundation
import UIKit
import MBProgressHUD

enum ApplicationError: Error {
    case unextectedData
    case wrongData
    case noData
}


class ErrorHandler {
    
    static let shared = ErrorHandler()
    private var queue: OperationQueue!
    
    private init() {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
    }
    
    func handleApplicaitonError(error: Error?) {
        print(error?.localizedDescription ?? "")
        enqueueError(string: LocalizableConstants.Error.GenericError.localized)
    }
    
    func handleServiceError(error: ResponseError?) {
        
        if let error = error {
            enqueueError(string: processError(error: error))
        } else {
            enqueueError(string: LocalizableConstants.Error.GenericError.localized)
        }
    }
    
    func processError(error: ResponseError) -> String  {
        
        if (error == .NoNetwork) {
            return LocalizableConstants.Error.NoNetwork.localized
        } else {
            return LocalizableConstants.Error.GenericError.localized
        }
    }
    
    private func enqueueError(string: String) {
        queue.addOperation {
            self.showError(string: string)
        }
    }
    
    private func showError(string: String) {
        
        self.queue.isSuspended = true
        
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: UIApplication.getRootView()!.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.offset = CGPoint(x: 0, y: -UIScreen.main.bounds.size.height/2 + hud.label.intrinsicContentSize.height + 80)
            hud.label.text = string
            hud.label.numberOfLines = -1
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
                MBProgressHUD.hide(for: UIApplication.getRootView()!.view, animated: true)
                self?.queue.isSuspended = false
            }
        }
    }
}
