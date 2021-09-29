//
//  MealViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class MealViewController: UIViewController {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    let networkingService = NetworkingService()
    var id = String()
    var meals = [IDMeal]() {
        didSet {
            guard let meal = meals.first else { return }
            DispatchQueue.main.async { [self] in
                nameTextView.text = meal.name.titlized()
                ingredientsTextView.text = formatIngredients(of: meal)
                instructionsTextView.text = meal.instructions.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipe"
        loadMeals()
    }

    // MARK: - Data Management

    func loadMeals() {
        typealias ResultAlias = Result<IDMeals, NetworkingError>
        networkingService.fetch(.meals(with: id), handler: { [weak self] (result: ResultAlias) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self?.meals = meals.all
                case .failure(let error):
                    self?.handle(error, retryHandler: {
                        self?.loadMeals()
                    })
                }
            }
        })
    }

    func formatIngredients(of meal: IDMeal) -> String {
        var list = String()

        for index in meal.ingredients.indices {
            let ingredient = meal.ingredients.keys[index].trimmingCharacters(in: .whitespaces)
            if var measure = meal.ingredients.values[index] {
                measure = measure.trimmingCharacters(in: .whitespaces)
                if !ingredient.isEmpty && !measure.isEmpty { list += "• \(ingredient), \(measure)\n" }
            } else {
                if !ingredient.isEmpty { list += "• \(ingredient)" }
            }
        }

        list = list.trimmingCharacters(in: .newlines)
        return list.isEmpty ? "Not Available" : list
    }
}
