//
//  Meal.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/22/24.
//

import Foundation

struct MealDetails: Decodable, Identifiable {
    var id: String { idMeal }
    
    var idMeal: String
    var strMeal: String
    var strInstructions: String?
    var strMealThumb: String?
    var strCategory: String?
    var ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strCategory
        case strInstructions
        case strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
       
        ingredients = []
        for i in 1...20 {
            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)"), let measureKey = CodingKeys(stringValue: "strMeasure\(i)") {
                if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey), let measure = try container.decodeIfPresent(String.self, forKey: measureKey), !ingredient.isEmpty {
                    ingredients.append(Ingredient(name: ingredient, measure: measure))
                }
            }
        }
    }
}

struct Meal: Decodable, Identifiable {
    var id: String { idMeal }
    
    var idMeal: String
    var strMeal: String
    var strMealThumb: String?
}

struct MealDetailResponse: Decodable {
    var meals: [MealDetails]
}

struct MealListResponse: Decodable {
    var meals: [Meal]
}

struct Ingredient {
    var name: String
    var measure: String
}
