//
//  CategoryMeals.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Category Meals
struct CategoryMeals: Decodable {
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }

    let all: [CategoryMeal]
}

// MARK: - Category Meal
struct CategoryMeal: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
    }

    let name: String
    let id: String
}
