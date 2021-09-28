//
//  InitialController.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import UIKit
import MapKit
import MBProgressHUD

class InitialController: UIViewController, Coordinating {

    var viewModel: InitialControllerViewModel?
    var coordinator: Coordinator?

    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailsView: CarDetailsView!
    @IBOutlet weak var detailsBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var mapTabItem: UIButton!
    @IBOutlet weak var listTabItem: UIButton!
    
    var refreshButton: UIBarButtonItem {
        return UIBarButtonItem.init(title: "Refresh", style: .done, target: self, action: #selector(refresh))
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel = InitialControllerViewModel(owner: self)
        mapView.delegate = self
        detailsView.delegate = self
        
    }
    
    @objc func refresh() {
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        configureTabBarForInitialLaunch()
        configureTableView()
        detailsBottomConstraint.constant = -CGFloat(NumberConstants.DetailsViewHeight)
        detailsView.layoutIfNeeded()
        
    }
    
    func configureTabBarForInitialLaunch() {
        
        // Set TabBar UI
        listTabItem.tintColor = ColorProfiles.TabBarDeselectColor
        mapTabItem.tintColor = ColorProfiles.BlueAccentColor
        
        // Set TabBar Actions
        listTabItem.addTarget(self, action: #selector(showListView), for: .touchUpInside)
        mapTabItem.addTarget(self, action: #selector(showMapView), for: .touchUpInside)
        
        // Prepare for view launch
        tabBar.isHidden = true
        detailsView.isHidden = true
        listView.isHidden = true
        listView.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchData()
    }
    
    
    func fetchData() {
        
        viewModel?.getCarDetails(completion: { [weak self] cars, error in
            
            // Handle Error
            if (error != nil) {
                
                ErrorHandler.shared.handleServiceError(error: error)
                
                if (error == .NoNetwork){
                    DispatchQueue.main.async {
                        self?.tabBar.isHidden = true
                        self?.navigationItem.rightBarButtonItem = self?.refreshButton
                    }
                }
                
                return
            }
            
            // Update UI
            // Show Annotations on Map
            DispatchQueue.main.async {
                self?.tabBar.isHidden = false
                self?.navigationItem.rightBarButtonItem = nil
                self?.addMapAnnotations()
            }
        })
    }
    
    func addMapAnnotations() {
        
        defer {
            fitMapViewToAnnotaionList(annotations: mapView.annotations)
            
            // Animate detail view, show detail about the car
            detailsView.isHidden = false
            detailsBottomConstraint.constant = 0
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: {
                self.view.layoutIfNeeded()
            })
            
            // Load data in details view
            do {
                try self.detailsView.configureView(with: viewModel?.cars?.first)
            } catch {
                ErrorHandler.shared.handleApplicaitonError(error: error)
            }
        }
        
        // Show All car's locaion on map
        viewModel?.cars?.forEach({ details in
            
            let annotation = ASAnnotatation()
            annotation.id = details.id
            annotation.title = details.name
            annotation.subtitle = " \(details.make ?? "") \(details.modelName ?? "") "
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(details.latitude ?? 0.0),
                                                           longitude: CLLocationDegrees(details.longitude ?? 0.0))
            self.mapView.addAnnotation(annotation)
        })
    }
    
    func fitMapViewToAnnotaionList(annotations: [MKAnnotation]) -> Void {
        
        // Show all map annotaions on map
        mapView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 70, right: 10)
        mapView.showAnnotations(annotations, animated: true)
    }
    
    @objc func showMapView() {
        
        mapView.isHidden = false
        detailsView.isHidden = false
        listView.isHidden = true
        listView.isUserInteractionEnabled = false
        listTabItem.tintColor = ColorProfiles.TabBarDeselectColor
        mapTabItem.tintColor = ColorProfiles.BlueAccentColor
    }
    
    @objc func showListView() {
        
        mapView.isHidden = true
        detailsView.isHidden = true
        listView.isHidden = false
        listView.isUserInteractionEnabled = true
        listTabItem.tintColor = ColorProfiles.BlueAccentColor
        mapTabItem.tintColor = ColorProfiles.TabBarDeselectColor
        listView.reloadData()
    }
}


extension InitialController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // Handle tap on Map's annotation point
        // Findout the data for annotation and show detail view
        if let view = view.annotation as? ASAnnotatation {
            if let details = viewModel?.getCarDetails(with: view.id) {
                do {
                    try self.detailsView.configureView(with: details)
                } catch {
                    ErrorHandler.shared.handleApplicaitonError(error: error)
                }
            }
        }
    }
}


extension InitialController: CarDetailProtocol {
    
    // Details view Locate button tapped
    // Notify coordinator about the event
    func didSelectLocateCar(res: Result<CLLocationCoordinate2D?, ApplicationError>) {
        
        do {
            switch res {
            case .success(let location):
                try self.coordinator?.eventOccured(event: .openMaps(location: location!))
            case .failure(let error):
                ErrorHandler.shared.handleApplicaitonError(error: error)
            }
            
        } catch {
            ErrorHandler.shared.handleApplicaitonError(error: error)
        }
    }
    
    // Fetch car's Image and return to caller
    func getCarImage(with path: String, completion: @escaping (UIImage) -> ()) {
        viewModel?.getCarImage(path: path, completion: completion)
    }
}
