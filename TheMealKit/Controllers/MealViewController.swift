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
    let theMealDB = TheMealDB()
    var id = String()
    var meals = [Meal]() {
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
        theMealDB.request(.meal(by: id), then: { (meals: Meals) in
            self.meals = meals.all
        })
    }

    func formatIngredients(of meal: Meal) -> String {
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
