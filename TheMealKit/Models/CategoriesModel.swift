//
//  CategoriesModel.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 10/2/21.
//

import Foundation

protocol CategoriesModelDelegate: AnyObject {
    func loadedCategories(_ categories: [Category])
    func loadFailed(_ networkingError: NetworkingError)
}

class CategoriesModel {
    let cellIdentifier = "Categories Table View Cell"
    let segueIdentifier = "Categories Storyboard Segue"
    var categories = [Category]()

    let networkingService = NetworkingService()
    weak var categoriesModelDelegate: CategoriesModelDelegate?

    func loadCategories() {
        typealias ResultAlias = Result<Categories, NetworkingError>
        networkingService.fetch(.categories(), handler: { [weak self] (result: ResultAlias) in
            switch result {
            case .success(let categories):
                self?.categoriesModelDelegate?.loadedCategories(categories.all)
            case .failure(let networkingError):
                self?.categoriesModelDelegate?.loadFailed(networkingError)
            }
        })
    }
}
