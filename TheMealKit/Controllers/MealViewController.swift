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
    var mealID: String? {
        didSet {
            TheMealDB().requestMeal(by: mealID, completion: { self.meal = $0?.all.first })
        }
    }
    var meal: Meal? {
        didSet {
            collectIngredients(of: meal)
            collectMeasurements(of: meal)
            DispatchQueue.main.async { [self] in
                nameTextView.text = formatTitle(of: meal?.name)
                ingredientsTextView.text = formatList(of: ingredients, with: measurements)
                instructionsTextView.text = meal?.instructions.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    var ingredients = [String?]()
    var measurements = [String?]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectIngredients(of meal: Meal?) {
        ingredients = [
            meal?.ingredient1, meal?.ingredient2, meal?.ingredient3, meal?.ingredient4, meal?.ingredient5,
            meal?.ingredient6, meal?.ingredient7, meal?.ingredient8, meal?.ingredient9, meal?.ingredient10,
            meal?.ingredient11, meal?.ingredient12, meal?.ingredient13, meal?.ingredient14, meal?.ingredient15,
            meal?.ingredient16, meal?.ingredient17, meal?.ingredient18, meal?.ingredient19, meal?.ingredient20
        ]
    }

    func collectMeasurements(of meal: Meal?) {
        measurements = [
            meal?.measurement1, meal?.measurement2, meal?.measurement3, meal?.measurement4, meal?.measurement5,
            meal?.measurement6, meal?.measurement7, meal?.measurement8, meal?.measurement9, meal?.measurement10,
            meal?.measurement11, meal?.measurement12, meal?.measurement13, meal?.measurement14, meal?.measurement15,
            meal?.measurement16, meal?.measurement17, meal?.measurement18, meal?.measurement19,meal?.measurement20
        ]
    }
}
