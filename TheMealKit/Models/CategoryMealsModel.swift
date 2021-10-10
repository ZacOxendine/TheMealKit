//
//  CategoryMealsModel.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 10/2/21.
//

import Foundation

protocol CategoryMealsModelDelegate: AnyObject {
    func loadedCategoryMeals(_ categoryMeals: [CategoryMeal])
    func loadFailed(_ networkingError: NetworkingError)
}

class CategoryMealsModel {
    let cellIdentifier = "Category Meals Table View Cell"
    let segueIdentifier = "Category Meals Storyboard Segue"
    var categoryMeals = [CategoryMeal]()
    var category = String()

    let networkingService = NetworkingService()
    weak var categoryMealsModelDelegate: CategoryMealsModelDelegate?

    func loadCategoryMeals() {
        typealias ResultAlias = Result<CategoryMeals, NetworkingError>
        networkingService.fetch(.meals(from: category), handler: { [weak self] (result: ResultAlias) in
            switch result {
            case .success(let categoryMeals):
                self?.categoryMealsModelDelegate?.loadedCategoryMeals(categoryMeals.all)
            case .failure(let networkingError):
                self?.categoryMealsModelDelegate?.loadFailed(networkingError)
            }
        })
    }
}
