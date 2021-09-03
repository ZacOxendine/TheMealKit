//
//  Meal.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Meals
struct Meals: Decodable {
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }

    let all: [Meal]
}

// MARK: - Meal
struct Meal: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "strMeal", instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4,
             strIngredient5, strIngredient6, strIngredient7, strIngredient8,
             strIngredient9, strIngredient10, strIngredient11, strIngredient12,
             strIngredient13, strIngredient14, strIngredient15, strIngredient16,
             strIngredient17, strIngredient18, strIngredient19, strIngredient20,
             strMeasure1, strMeasure2, strMeasure3, strMeasure4,
             strMeasure5, strMeasure6, strMeasure7, strMeasure8,
             strMeasure9, strMeasure10, strMeasure11, strMeasure12,
             strMeasure13, strMeasure14, strMeasure15, strMeasure16,
             strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    var name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var ingredients: [String] = []
        var measurements: [String] = []

        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)

        for count in 1...20 {
            if let ingredient = try container.decodeIfPresent(String.self, forKey: .init(stringValue: "strIngredient\(count)")!) {
                ingredients.append(ingredient)
            }

            if let measurement = try container.decodeIfPresent(String.self, forKey: .init(stringValue: "strMeasure\(count)")!) {
                measurements.append(measurement)
            }
        }

        self.ingredients = ingredients
        self.measurements = measurements
    }
}
