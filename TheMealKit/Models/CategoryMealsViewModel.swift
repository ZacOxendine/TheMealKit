import Foundation

class CategoryMealsViewModel {
    let networkingService = NetworkingService()
    var category: Category?
    weak var delegate: CategoryMealsViewModelDelegate?

    func loadCategoryMeals() {
        if let category = category {
            typealias ResultAlias = Result<CategoryMeals, NetworkingError>
            networkingService.fetch(.meals(from: category.name), handler: { [weak self] (result: ResultAlias) in
                switch result {
                case .success(let categoryMeals):
                    self?.delegate?.loadedCategoryMeals(categoryMeals.all)
                case .failure(let networkingError):
                    self?.delegate?.loadFailed(networkingError)
                }
            })
        }
    }
}
