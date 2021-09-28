//
//  Coordinator.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation
import UIKit
import CoreLocation

enum Events {
    case openMaps(location: CLLocationCoordinate2D)
}

protocol Coordinator {
    
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(event: Events) throws
    func start()
}


protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
