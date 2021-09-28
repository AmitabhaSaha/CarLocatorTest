//
//  HTTPError.swift
///  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//


import Foundation


enum ResponseError: Error {
    case APIError
    case NoLocalData
    case NoNetwork
    case serializationError
}
