//
//  InitialControllerViewModel.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation
import UIKit.UIImage

class InitialControllerViewModel {
    
    var cars: [CarDetails]?
    weak var owner: UIViewController?
    
    init(owner: UIViewController) {
        self.owner = owner
    }
    
    func getCarDetails(completion: @escaping ([CarDetails]?, ResponseError?) -> Void ) {
        
        if (cars != nil) {
            completion(cars, nil)
            return
        }
        
        // Fetch car details
        owner?.showProgressBar()
        ServiceRepository.getCarsData { [weak self] result in
            self?.owner?.hideProgressBar()
            switch result {
            case .success(let response):
                self?.cars = response
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getCarImage(path: String, completion: @escaping (UIImage) -> Void ) {
        
        // Fetch car's image
        ServiceRepository.getImage(with: path) { result in
            switch result {
            case .success(let response):
                completion(response!)
            case .failure(_):
                
                // Default image to be used in case of car's image is not present
                // or in case of any error
                completion(UIImage.init(named: "car") ?? UIImage())
            }
        }
    }
    
    func getCarDetails(with id: String?) -> CarDetails? {
        return cars?.filter({$0.id == id}).first
    }
}
