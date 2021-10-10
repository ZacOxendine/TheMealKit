//
//  IDMealsModel.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 10/2/21.
//

import Foundation

protocol IDMealsModelDelegate: AnyObject {
    func loadedIDMeals(_ idMeals: [IDMeal])
    func loadFailed(_ networkingError: NetworkingError)
}

class IDMealsModel {
    var idMeal: IDMeal?
    var id = String()

    let networkingService = NetworkingService()
    weak var idMealsModelDelegate: IDMealsModelDelegate?

    func loadIDMeals() {
        typealias ResultAlias = Result<IDMeals, NetworkingError>
        networkingService.fetch(.meals(with: id), handler: { [weak self] (result: ResultAlias) in
            switch result {
            case .success(let idMeals):
                self?.idMealsModelDelegate?.loadedIDMeals(idMeals.all)
            case .failure(let networkingError):
                self?.idMealsModelDelegate?.loadFailed(networkingError)
            }
        })
    }

    func listIngredients(of idMeal: IDMeal) -> String {
        var ingredients = String()
        var ingredientsList = [String]()

        for (ingredient, measure) in idMeal.ingredients {
            if ingredient.isEmpty {
                continue
            } else {
                if let measure = measure {
                    ingredientsList.append("\(ingredient) (\(measure))")
                } else {
                    ingredientsList.append(ingredient)
                }
            }
        }

        ingredientsList = ingredientsList.sorted(by: { $0.count < $1.count })
        for ingredient in ingredientsList { ingredients.append("• \(ingredient)\n") }
        ingredients = ingredients.trimmingCharacters(in: .newlines)
        return ingredients.isEmpty ? "Ingredients Not Found" : ingredients
    }
}
