//
//  CarDetailsView.swift
//  CarLocator
//
//  Created by Amitabha Saha on 26/09/21.
//

import UIKit
import MapKit
import CoreLocation

class CarDetailsView: UIView {
    
    private var dataModel: CarDetails?
    var delegate: CarDetailProtocol?
    
    @IBOutlet weak var cleanImage: UIImageView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeSerieslabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var fuelRange: UILabel!
    @IBOutlet weak var trsnamissionType: UILabel!
    
    var didSelectLocateCar: ((Result<CLLocationCoordinate2D?,ApplicationError>)->())?
    
    func configureView(with dataModel: CarDetails?) throws {
        
        guard let dataModel = dataModel else {
            throw ApplicationError.noData
        }
        
        self.dataModel = dataModel
        
        nameLabel.text = dataModel.name
        makeSerieslabel.text = " \(dataModel.make ?? "") \(dataModel.modelName ?? "") "
        licenseLabel.text = dataModel.licensePlate
        fuelRange.text = dataModel.getFuelType() + " - \(dataModel.getFuelLevel())%"
        trsnamissionType.text = dataModel.getTransmissionType()
        cleanImage.image = dataModel.getCleanImage()
        
        delegate?.getCarImage(with: dataModel.carImageUrl ?? "", completion: { img in
            DispatchQueue.main.async { [weak self] in
                self?.carImage.image = img
            }
        })
    }
    
    @IBAction func locateCar(_ sender: Any) {
        
        if let location = dataModel?.getCarLocation() {
            delegate?.didSelectLocateCar(res: .success(location))
        } else {
            delegate?.didSelectLocateCar(res: .failure(.noData))
        }
    }
}
