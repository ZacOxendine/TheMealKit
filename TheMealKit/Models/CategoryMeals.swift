//
//  CategoryMeals.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Category Meals
struct CategoryMeals: Decodable {
    let all: [CategoryMeal]

    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

// MARK: - Category Meal
struct CategoryMeal: Decodable {
    let name: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
    }
}
