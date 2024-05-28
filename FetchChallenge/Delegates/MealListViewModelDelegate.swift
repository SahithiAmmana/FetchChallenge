//
//  MealListViewModelDelegate.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/27/24.
//

import Foundation

protocol MealListViewModelDelegate: AnyObject {
    func didFetchMealList(meals: [Meal])
    func didFailWithError(error: Error)
}
