//
//  LocalResponseTests.swift
//  CarLocatorTests
//
//  Created by Amitabha Saha on 28/09/21.
//

import XCTest
@testable import CarLocator

class LocalResponseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_localResponse_cars_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let CarDetailsExpectation = expectation(description: "CarDetails")
        
        var cars: [CarDetails]?
        ServiceRepository.getCarsData(localData: (true, "LocalCarData")) { result in
            switch result {
            case .success(let response):
                cars = response
                CarDetailsExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(cars)
        }
    }
    
    func test_localResponse_cars_count() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let CarDetailsExpectation = expectation(description: "CarDetails")
        
        var cars: [CarDetails]?
        ServiceRepository.getCarsData(localData: (true, "LocalCarData")) { result in
            switch result {
            case .success(let response):
                cars = response
                CarDetailsExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertTrue(cars?.count == 8, "Failed to load all card data")
        }
    }
    
    func test_localResponse_cars_failure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let CarDetailsExpectation = expectation(description: "CarDetails")
        
        var cars: [CarDetails]?
        ServiceRepository.getCarsData(localData: (true, "CarData")) { result in
            switch result {
            case .success(let response):
                cars = response
                CarDetailsExpectation.fulfill()
            case .failure(_):
                CarDetailsExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(cars)
        }
    }
    
    func test_localResponse_image_success() throws {
        
        let imageExpectation = expectation(description: "Image")
        var image: UIImage?
        
        ServiceRepository.getImage(localData: true, with: "") { result in
            switch result {
            case .success(let imageResponse):
                image = imageResponse
                imageExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(image)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
