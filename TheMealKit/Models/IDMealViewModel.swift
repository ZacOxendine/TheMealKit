import Foundation

class IDMealViewModel {
    let networkingService = NetworkingService()
    var categoryMeal: CategoryMeal?
    weak var delegate: IDMealViewModelDelegate?

    func loadIDMeals() {
        if let categoryMeal = categoryMeal {
            typealias ResultAlias = Result<IDMeals, NetworkingError>
            networkingService.fetch(.meals(with: categoryMeal.id), handler: { [weak self] (result: ResultAlias) in
                switch result {
                case .success(let idMeals):
                    self?.delegate?.loadedIDMeals(idMeals.all)
                case .failure(let networkingError):
                    self?.delegate?.loadFailed(networkingError)
                }
            })
        }
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
