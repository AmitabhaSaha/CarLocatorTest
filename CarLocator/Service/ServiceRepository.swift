//
//  APIManager.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//

import Foundation
import UIKit

typealias localJSON = (Bool, String?)

enum Request {
    case cars(path: String)
    case image(path: String)
    
    var baseURL: String {
        return "https://cdn.sixt.io/codingtask"
    }
    
    func getRequest() -> HTTPrequest {
        switch self {
            
        case .cars(let path):
            return HTTPrequest(url: baseURL + path, headers: nil, body: nil)
        
        case .image(let path):
            return HTTPrequest(url: path, headers: nil, body: nil)
        }
    }
}

class ServiceRepository {
    
    typealias ListCompletion = ((Result<[CarDetails]?,ResponseError>)->())
    typealias ImageCompletion = ((Result<UIImage?,ResponseError>)->())
    typealias APICompletion = ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ())
    
    private static func checkNoNetworkResponse(error: Error) -> Bool {
        return (error._code == -1009 || error._code == -1020)
    }
    
    static func getCarsData(localData: localJSON = (false, nil), completion: @escaping ListCompletion) {
        
        let request = Request.cars(path: "/cars").getRequest()
        request.response(localData: localData, decodeTo: [CarDetails].self) { (model, response, error) in
            if let error = error {
                if ServiceRepository.checkNoNetworkResponse(error: error) {
                    completion(.failure(.NoNetwork))
                } else {
                    completion(.failure(.APIError))
                }
            } else {
                completion(.success(model))
            }
        }
    }
    
    static func getImage(localData: Bool = false, with path: String, completion: @escaping ImageCompletion) {
        
        if (localData) {
            completion(.success(UIImage(named: "car")!))
            return
        }
        
        if let image = ASCache.instance.getImageFromCache(for: path) {
            completion(.success(image))
        } else {
            let request = Request.image(path: path).getRequest()
            request.responseImage() { (image, response, error) in
                if let error = error {
                    if ServiceRepository.checkNoNetworkResponse(error: error) {
                        completion(.failure(.NoNetwork))
                    } else {
                        completion(.failure(.APIError))
                    }
                } else {
                    if let image = image {
                        ASCache.instance.setToCache(image: image, for: path)
                    }
                    completion(.success(image))
                }
            }
        }
    }
}
