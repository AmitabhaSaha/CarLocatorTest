//
//  ResponseModel.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation
import UIKit
import MapKit

struct CarDetails: Codable {
    
    var id: String?
    var modelIdentifier: String?
    var modelName: String?
    var name: String?
    var make: String?
    var group: String?
    var color: String?
    var series: String?
    var fuelType: String?
    var fuelLevel: Float?
    var transmission: String?
    var licensePlate: String?
    var latitude: Double?
    var longitude: Double?
    var innerCleanliness: String?
    var carImageUrl: String?
    
    func getFuelLevel() -> Int {
        guard let fuelLevel = fuelLevel else { return 0 }
        return Int(fuelLevel*100.0)
    }
    
    func getTransmissionType() -> String {
        guard let transmission = transmission else { return "" }
        
        switch transmission {
        case "M":
            return LocalizableConstants.InitialView.ManualKey.localized
        case "A":
            return LocalizableConstants.InitialView.AutoKey.localized
        default:
            return LocalizableConstants.InitialView.Unknown.localized
        }
    }
    
    func getFuelType() -> String {
        guard let fuelType = fuelType else { return "" }
        
        switch fuelType {
        case "D":
            return LocalizableConstants.InitialView.DieselKey.localized
        case "P":
            return LocalizableConstants.InitialView.PetrolKey.localized
        case "E":
            return LocalizableConstants.InitialView.EVKey.localized
        default:
            return LocalizableConstants.InitialView.Unknown.localized
        }
    }
    
    func getCleanImage() -> UIImage {
        guard let innerCleanliness = innerCleanliness else { return UIImage() }
        
        switch innerCleanliness {
        case "CLEAN":
            return #imageLiteral(resourceName: "clean")
        case "VERY_CLEAN":
            return #imageLiteral(resourceName: "very_clean")
        default:
            return UIImage()
        }
    }
    
    
    func getCarColor() -> String {
        guard let color = color else { return "White" }
        
        return color.localized
    }
    
    func getCarLocation() -> CLLocationCoordinate2D? {
        guard let lat = self.latitude, let lon = self.longitude else {
            return nil
        }
        
        let location = CLLocationCoordinate2DMake(lat, lon)
        
        if (CLLocationCoordinate2DIsValid(location)) {
            return location
        }
        
        return nil
    }
}
