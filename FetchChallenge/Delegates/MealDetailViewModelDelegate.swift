//
//  MealDetailViewModelDelegate.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/24/24.
//

import Foundation

protocol MealDetailViewModelDelegate: AnyObject {
    func didFetchMealDetails(mealDetail: MealDetails?)
}
