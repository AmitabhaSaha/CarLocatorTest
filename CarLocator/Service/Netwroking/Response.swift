//
//  Response.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//


import Foundation
import UIKit

extension HTTPrequest {
    
    public func response<T: Decodable>(localData: localJSON = (false, nil), decodeTo: T.Type = T.self, completion: @escaping ((_ data: T?, _ response: URLResponse?, _ error: Error?) -> ())) {
        
        let networkManager = NetworkLayer()
        networkManager.localResponse = localData
        networkManager.request = self
        networkManager.didFinishDownloadedData = { (data, error, request, response) in
            if let error = error {
                completion(nil, response, error)
            } else {
                
                if let st = String(data: data!, encoding: .ascii), let data1 = st.data(using: .utf8) {
                    
                    do {
                        let decodedModel = try JSONDecoder().decode(T.self, from: data1)
                        completion(decodedModel, response, error)
                        
                    } catch {
                        completion(nil, response, ResponseError.serializationError)
                    }
                    
                } else {
                    completion(nil, response, error)
                }
            }
        }
        
        networkManager.resumeTask()
    }
    
    public func responseImage( completion: @escaping ((_ image: UIImage?, _ response: URLResponse?, _ error: Error?) -> ())) {
        let networkManager = NetworkLayer()
        networkManager.request = self
        networkManager.resumeTask()
        networkManager.didFinishDownloadedData = { (data, error, request, response) in
            if let error = error {
                completion(nil, response, error)
            } else {
                
                if let data = data,
                    let image = UIImage.init(data: data) {
                    completion(image, response, error)
                } else {
                    completion(nil, response, ResponseError.APIError)
                }
            }
        }
    }
}
