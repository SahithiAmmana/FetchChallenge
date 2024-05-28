//
//  MealListViewModelTests.swift
//  FetchChallengeTests
//
//  Created by Sahithi Ammana on 5/28/24.
//

import XCTest
@testable import FetchChallenge

class MealListViewModelTests: XCTestCase {
    
    var viewModel: MealListViewModel!
    var mockDelegate: MockMealListViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        let mockNetwork = MockNetwork()
        viewModel = MealListViewModel(network: mockNetwork)
        mockDelegate = MockMealListViewModelDelegate()
        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchMealList() {
        viewModel.fetchMealList()
        
        let expectation = self.expectation(description: "Fetching meal list in view model")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.meals.isEmpty, "Meals in view model should not be empty")
            XCTAssertEqual(self.viewModel.meals.first?.strMeal, "Apple & Blackberry Crumble", "First meal in view model should be Apple & Blackberry Crumble")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockMealListViewModelDelegate: MealListViewModelDelegate {
    func didFetchMealList(meals: [Meal]) {}
    func didFailWithError(error: Error) {}
}
