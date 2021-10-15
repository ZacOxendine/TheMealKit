import UIKit

class IDMealViewController: UIViewController {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    let viewModel = IDMealViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipe"
        viewModel.delegate = self
        viewModel.loadIDMeals()
    }
}

// MARK: - Delegation

extension IDMealViewController: IDMealViewModelDelegate {
    func loadedIDMeals(_ idMeals: [IDMeal]) {
        DispatchQueue.main.async {
            if let idMeal = idMeals.first {
                self.nameTextView.text = idMeal.name
                self.instructionsTextView.text = idMeal.instructions
                self.ingredientsTextView.text = self.viewModel.listIngredients(of: idMeal)
            }
        }
    }

    func loadFailed(_ networkingError: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(networkingError, retryHandler: {
                self.viewModel.loadIDMeals()
            })
        }
    }
}

protocol IDMealViewModelDelegate: AnyObject {
    func loadedIDMeals(_ idMeals: [IDMeal])
    func loadFailed(_ networkingError: NetworkingError)
}
