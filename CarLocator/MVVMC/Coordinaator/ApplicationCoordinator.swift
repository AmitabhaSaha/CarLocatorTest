//
//  ApplicationCoordinator.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class ApplicationCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        
        if var initialVC : UIViewController & Coordinating = UIStoryboard(name: StoryboardConstants.InitialStrotyboard, bundle: nil).instantiateViewController(identifier: StoryboardConstants.InitialController) as? InitialController {
            
            initialVC.coordinator = self
            navigationController?.setViewControllers([initialVC], animated: false)
        }
    }
    
    func eventOccured(event: Events) throws {
        switch event {
        
        case .openMaps(let location):
            try openMaps(location: location)
        }
    }
}

extension ApplicationCoordinator {
    
    func openMaps(location: CLLocationCoordinate2D) throws {
        
        if (CLLocationCoordinate2DIsValid(location) == false ) {
            throw ApplicationError.unextectedData
        }
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: location))
                
        MKMapItem.openMaps(
          with: [destination],
          launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
}
