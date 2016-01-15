//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Adela Gao on 1/10/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import XCTest

class Meal {
    var name = ""
    func testState() {
        name = "changed"
    }
}

@testable import MyFoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMealNameValidity() {
        let mealvc = MealViewController()
        let validMealName = "Dinner"
        XCTAssertTrue(mealvc.isValidMealName(validMealName))
        
        let invalidMealName = ""
        XCTAssertFalse(mealvc.isValidMealName(invalidMealName))
    }
    
    func testExample() {
        let myMeal = MyFoodTracker.Meal(name: "new meal", photo: nil, rating: 3)
        let testMeal = Meal()
        testMeal.testState()
        XCTAssert(testMeal.name == "changed", "meal name should change after calling testState()")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
