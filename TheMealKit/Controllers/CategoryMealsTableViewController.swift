import UIKit

class CategoryMealsTableViewController: UITableViewController {
    let dataSource = CategoryMealsTableViewDataSource()
    let viewModel = CategoryMealsViewModel()
    let identifier = "Category Meals Storyboard Segue"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        navigationItem.title = viewModel.category?.name
        viewModel.delegate = self
        viewModel.loadCategoryMeals()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let categoryMeal = dataSource.categoryMeals[indexPath.row]
                let idMealViewController = segue.destination as! IDMealViewController
                idMealViewController.viewModel.categoryMeal = categoryMeal
            }
        }
    }
}

// MARK: - Delegation

extension CategoryMealsTableViewController: CategoryMealsViewModelDelegate {
    func loadedCategoryMeals(_ meals: [CategoryMeal]) {
        DispatchQueue.main.async {
            self.dataSource.categoryMeals = meals
            self.tableView.reloadData()
        }
    }

    func loadFailed(_ error: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(error, retryHandler: {
                self.viewModel.loadCategoryMeals()
            })
        }
    }
}

protocol CategoryMealsViewModelDelegate: AnyObject {
    func loadedCategoryMeals(_ categoryMeals: [CategoryMeal])
    func loadFailed(_ networkingError: NetworkingError)
}
