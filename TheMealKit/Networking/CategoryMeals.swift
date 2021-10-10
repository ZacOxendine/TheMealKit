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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Category Meal Sorting
        let all = try container.decode([CategoryMeal].self, forKey: .all)
        self.all = all.sorted(by: { $0.name < $1.name })
    }

    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

// MARK: - Category Meal
struct CategoryMeal: Decodable {
    let name: String
    let id: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Name Formatting
        let name = try container.decode(String.self, forKey: .name)
        self.name = name.formatted(as: .name)

        // ID Formatting
        let id = try container.decode(String.self, forKey: .id)
        self.id = id.formatted(as: .id)
    }

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
    }
}
