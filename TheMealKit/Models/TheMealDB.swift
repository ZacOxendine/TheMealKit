//
//  TheMealDB.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

class TheMealDB {
    // Request & Decode Data from Categories Endpoint
    func requestCategories(completion: @escaping (Categories?) -> Void) {
        URLSession.shared.dataTask(with: Endpoint.categories().url) { data, _, error in
            guard let data = data else { fatalError(error?.localizedDescription ?? "unknown error") }
            if let decodedData = try? JSONDecoder().decode(Categories.self, from: data) { completion(decodedData) }
        }.resume()
    }

    // Request & Decode Data from Filter Meals by Category Endpoint
    func requestMeals(by category: String?, completion: @escaping (CategoryMeals?) -> Void) {
        guard let category = category else { fatalError("invalid meal category") }
        URLSession.shared.dataTask(with: Endpoint.meals(by: category).url) { data, _, error in
            guard let data = data else { fatalError(error?.localizedDescription ?? "unknown error") }
            if let decodedData = try? JSONDecoder().decode(CategoryMeals.self, from: data) { completion(decodedData) }
        }.resume()
    }

    // Request & Decode Data from Lookup Meal by ID Endpoint
    func requestMeal(by id: String?, completion: @escaping (Meals?) -> Void) {
        guard let id = id else { fatalError("invalid meal id") }
        URLSession.shared.dataTask(with: Endpoint.meal(by: id).url) { data, _, error in
            guard let data = data else { fatalError(error?.localizedDescription ?? "unknown error") }
            if let decodedData = try? JSONDecoder().decode(Meals.self, from: data) { completion(decodedData) }
        }.resume()
    }
}
