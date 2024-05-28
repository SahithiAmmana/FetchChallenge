//
//  MealListViewModel.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/24/24.
//

import Foundation

class MealListViewModel {
        
    private let network: Network
    var meals: [Meal] = []
    weak var delegate: MealListViewModelDelegate?
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    // Fetch Meal List
    func fetchMealList() {
        self.network.fetchMealList { [weak self] meals in
            guard let weakSelf = self, let delegate = weakSelf.delegate else { return }
            let sortedMeals = meals.sorted {
                $0.strMeal < $1.strMeal
            }
            if sortedMeals.isEmpty {
                delegate.didFailWithError(error: NSError(domain: "No data", code: 1, userInfo: nil))
            } else {
                weakSelf.meals = sortedMeals
                delegate.didFetchMealList(meals: sortedMeals)
            }
        }
    }
    
    // Meal at Index
    func meal(at index: Int) -> Meal {
        return meals[index]
    }
}
