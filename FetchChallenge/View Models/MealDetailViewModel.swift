//
//  MealDetailViewModel.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/24/24.
//

import Foundation

class MealDetailViewModel {
    
    private let network: Network
    weak var delegate: MealDetailViewModelDelegate?
        
    init(network: Network = Network()) {
        self.network = network
    }
    
    //Fetch Meal Details
    func fetchMealDetails(idMeal: String) {
        self.network.fetchMealDetails(idMeal: idMeal) { [weak self] mealDetail in
            guard let weakSelf = self, let delegate = weakSelf.delegate else { return }
            DispatchQueue.main.async {
                delegate.didFetchMealDetails(mealDetail: mealDetail)
            }
        }
    }
    
}
