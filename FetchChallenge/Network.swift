//
//  Network.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/22/24.
//

import Foundation

class Network {
    
    // Fetch list of meals in dessert category
    func fetchMealList(completion: @escaping ([Meal]) -> Void) {
        let url = URL(string: APIEndpoints.dessertList)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(MealListResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData.meals)
                }
            } catch {
                print(error)
                completion([])
            }
        }.resume()
    }
    
    // Fetch meal details
    func fetchMealDetails(idMeal: String, completion: @escaping (MealDetails?) -> Void) {
        guard let url = URL(string: APIEndpoints.mealDetails(for: idMeal)) else { return completion(nil) }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData.meals.first)
                }
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
