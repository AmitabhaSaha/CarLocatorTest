//
//  CacheTests.swift
//  CarLocatorTests
//
//  Created by Amitabha Saha on 28/09/21.
//

import XCTest
@testable import CarLocator


class CacheTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func test_cache_failure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let image = ASCache.instance.getImageFromCache(for: "cache_image")
        XCTAssertNil(image)
    }

    func test_cache_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        ASCache.instance.setToCache(image: UIImage.init(named: "car")!, for: "cache_image")
        let image = ASCache.instance.getImageFromCache(for: "cache_image")
        XCTAssertNotNil(image)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
