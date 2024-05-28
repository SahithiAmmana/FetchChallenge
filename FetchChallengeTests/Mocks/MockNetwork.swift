//
//  MockNetwork.swift
//  FetchChallengeTests
//
//  Created by Sahithi Ammana on 5/27/24.
//

import Foundation
@testable import FetchChallenge

class MockNetwork: Network {
    
    override func fetchMealList(completion: @escaping ([Meal]) -> Void) {
        let mockMeals = [
            Meal(idMeal: "52768", strMeal: "Apple & Blackberry Crumble", strMealThumb: nil),
            Meal(idMeal: "52893", strMeal: "Apple Frangipan Tart", strMealThumb: nil)
        ]
        completion(mockMeals)
    }
    
    override func fetchMealDetails(idMeal: String, completion: @escaping (MealDetails?) -> Void) {
        let json: [String: Any] = [
            "idMeal": "52772",
            "strMeal": "Teriyaki Chicken Casserole",
            "strCategory": "Chicken",
            "strInstructions": "Preheat oven to 350 degrees F...",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            "strIngredient1": "soy sauce",
            "strMeasure1": "3/4 cup",
            "strIngredient2": "water",
            "strMeasure2": "1/2 cup",
            "strIngredient3": "brown sugar",
            "strMeasure3": "1/4 cup packed"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let mealDetail = try JSONDecoder().decode(MealDetails.self, from: data)
            completion(mealDetail)
        } catch {
            completion(nil)
        }
    }
}
