//
//  CategoryMeals.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Category Meals
struct CategoryMeals: Codable {
    let all: [CategoryMeal]

    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

// MARK: - Category Meal
struct CategoryMeal: Codable {
    let name: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
    }
}
