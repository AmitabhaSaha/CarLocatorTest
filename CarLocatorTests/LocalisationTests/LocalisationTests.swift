//
//  LocalisationTests.swift
//  CarLocatorTests
//
//  Created by Amitabha Saha on 28/09/21.
//

import XCTest
@testable import CarLocator

class LocalisationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_localised_strings() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let manualKey = LocalizableConstants.InitialView.ManualKey.localized
        XCTAssertTrue(manualKey == "Manual", "Wrong Key Fetched")
        
        let autolKey = LocalizableConstants.InitialView.AutoKey.localized
        XCTAssertTrue(autolKey == "Autometic", "Wrong Key Fetched")
        
        let unknown = LocalizableConstants.InitialView.Unknown.localized
        XCTAssertTrue(unknown == "Unknown", "Wrong Key Fetched")
        
        let dieselKey = LocalizableConstants.InitialView.DieselKey.localized
        XCTAssertTrue(dieselKey == "Diesel", "Wrong Key Fetched")
        
        let petrolKey = LocalizableConstants.InitialView.PetrolKey.localized
        XCTAssertTrue(petrolKey == "Petrol", "Wrong Key Fetched")
        
        let evKey = LocalizableConstants.InitialView.EVKey.localized
        XCTAssertTrue(evKey == "EV", "Wrong Key Fetched")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
