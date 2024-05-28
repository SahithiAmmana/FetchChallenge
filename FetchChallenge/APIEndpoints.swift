//
//  APIEndpoints.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/27/24.
//

import Foundation

struct APIEndpoints {
    static let base = "https://themealdb.com/api/json/v1/1"
    
    static let dessertList = "\(base)/filter.php?c=Dessert"
    static func mealDetails(for id: String) -> String {
        return "\(base)/lookup.php?i=\(id)"
    }
}
