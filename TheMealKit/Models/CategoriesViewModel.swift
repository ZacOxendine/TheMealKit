import Foundation

class CategoriesViewModel {
    let networkingService = NetworkingService()
    weak var delegate: CategoriesViewModelDelegate?

    func loadCategories() {
        typealias ResultAlias = Result<Categories, NetworkingError>
        networkingService.fetch(.categories(), handler: { [weak self] (result: ResultAlias) in
            switch result {
            case .success(let categories):
                self?.delegate?.loadedCategories(categories.all)
            case .failure(let networkingError):
                self?.delegate?.loadFailed(networkingError)
            }
        })
    }
}
