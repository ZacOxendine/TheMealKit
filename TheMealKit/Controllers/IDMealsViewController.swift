//
//  IDMealsViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class IDMealsViewController: UIViewController {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    let idMealsModel = IDMealsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipe"
        idMealsModel.idMealsModelDelegate = self
        idMealsModel.loadIDMeals()
    }
}

extension IDMealsViewController: IDMealsModelDelegate {
    func loadedIDMeals(_ idMeals: [IDMeal]) {
        DispatchQueue.main.async {
            for idMeal in idMeals {
                self.idMealsModel.idMeal = idMeal
                self.nameTextView.text = idMeal.name
                self.instructionsTextView.text = idMeal.instructions
                self.ingredientsTextView.text = self.idMealsModel.listIngredients(of: idMeal)
            }
        }
    }

    func loadFailed(_ networkingError: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(networkingError, retryHandler: {
                self.idMealsModel.loadIDMeals()
            })
        }
    }
}
