//
//  Request.swift
//  CarLocator
//
//  Created by Amitabha Saha on 24/09/21.
//


import Foundation


protocol HTTPrequestProtocol {
    
    associatedtype DictionaryData
    
    var url: String {get set}
    var headers: DictionaryData? {get set}
    var body: DictionaryData? {get set}
    var method: String {get set}
}

class HTTPrequest: HTTPrequestProtocol {
    
    typealias DictionaryData = [String: Any]
    
    var url: String
    var headers: DictionaryData?
    var body: DictionaryData?
    var method: String = "GET"
    
    init(url: String, method: String = "GET", headers: DictionaryData?, body: DictionaryData?) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}
