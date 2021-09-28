//
//  InitialViewModelTests.swift
//  CarLocatorTests
//
//  Created by Amitabha Saha on 28/09/21.
//

import XCTest
@testable import CarLocator

class InitialViewModelTests: XCTestCase {
    
    var viewModel = InitialControllerViewModel.init(owner: UIViewController())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_get_cars() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let carDetailsExpectation = expectation(description: "CarDetails")
    
        viewModel.getCarDetails { [weak self] cars, error in
            
            if (error == nil) {
                carDetailsExpectation.fulfill()
                XCTAssertNotNil(self?.viewModel.cars)
                XCTAssertNotNil(cars)
                DispatchQueue.main.async {
                    try? self?.imageTest()
                    try? self?.dataModelTest()
                }
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    func imageTest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        if let carImageUrl = viewModel.cars?.first?.carImageUrl {
            let imgeExpectation = expectation(description: "image")
        
            viewModel.getCarImage(path: carImageUrl) { image in
                imgeExpectation.fulfill()
                XCTAssertNotNil(image)
            }
            
            waitForExpectations(timeout: 30.0, handler: nil)
        }
    }
    
    func dataModelTest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel.cars?.forEach({ car in
            
            let color = car.getCarColor()
            XCTAssertNotNil(color)
            
            let location = car.getCarLocation()
            XCTAssertNotNil(location)
            
            let fuelLevel = car.getFuelLevel()
            XCTAssertTrue(fuelLevel <= 100, "Wrong fuel level")
        })
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
}
