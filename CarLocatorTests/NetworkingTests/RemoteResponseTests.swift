//
//  RemoteResponseTests.swift
//  CarLocatorTests
//
//  Created by Amitabha Saha on 28/09/21.
//

import XCTest
@testable import CarLocator


class RemoteResponseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_response_cars_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let CarDetailsExpectation = expectation(description: "CarDetails")
        var cars: [CarDetails]?
        
        ServiceRepository.getCarsData { result in
            switch result {
            case .success(let response):
                cars = response
            case .failure(_):
                XCTFail()
            }
            
            CarDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(cars)
            if let cars = cars {
                XCTAssertTrue(cars.count > 0, "No Details received")
            }
        }
    }
    
    
    func test_response_image_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let imageExpectation = expectation(description: "image")
        var image: UIImage?
        
        ServiceRepository.getImage(with: "https://cdn.sixt.io/codingtask/images/mini.png") { result in
            switch result {
            case .success(let response):
                image = response
            case .failure(_):
                XCTFail()
            }
            
            imageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(image)
        }
    }
    
    func test_response_image_failure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let imageExpectation = expectation(description: "image")
        var image: UIImage?
        
        ServiceRepository.getImage(with: "https://cdn.sixt.io/codingtask/images/mini_1.png") { result in
        
            switch result {
            case .success(let response):
                image = response
                imageExpectation.fulfill()
            case .failure(_):
                imageExpectation.fulfill()
            }
            
            
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(image)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
