//
//  MealDetailViewModelTests.swift
//  FetchChallengeTests
//
//  Created by Sahithi Ammana on 5/28/24.
//

import XCTest
@testable import FetchChallenge

class MealDetailViewModelTests: XCTestCase {
    
    var detailViewModel: MealDetailViewModel!
    var mockDelegate: MockMealDetailViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        let mockNetwork = MockNetwork()
        detailViewModel = MealDetailViewModel(network: mockNetwork)
        mockDelegate = MockMealDetailViewModelDelegate()
        detailViewModel.delegate = mockDelegate
    }

    override func tearDown() {
        detailViewModel = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchMealDetails() {
        detailViewModel.fetchMealDetails(idMeal: "52772")
        
        let expectation = self.expectation(description: "Fetching meal details in view model")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.mockDelegate.mealDetail, "Meal details in view model should not be nil")
            XCTAssertEqual(self.mockDelegate.mealDetail?.strMeal, "Teriyaki Chicken Casserole", "Meal name in view model should be Teriyaki Chicken Casserole")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockMealDetailViewModelDelegate: MealDetailViewModelDelegate {
    var mealDetail: MealDetails?
    
    func didFetchMealDetails(mealDetail: MealDetails?) {
        self.mealDetail = mealDetail
    }
}
