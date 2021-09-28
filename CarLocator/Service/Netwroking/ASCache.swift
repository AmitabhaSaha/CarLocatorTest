//
//  ASCache.swift
//  CarLocator
//
//  Created by Amitabha Saha on 26/09/21.
//

import Foundation
import UIKit

class ASCache {
    
    static let instance = ASCache()
    
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    func setToCache(image: UIImage, for path: String) {
        cache.setObject(image, forKey: NSString(string: path))
    }
    
    func getImageFromCache(for path: String) -> UIImage? {
        if let image = cache.object(forKey: NSString(string: path)) {
            return image
        } else {
            return nil
        }
    }
}
