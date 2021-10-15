import UIKit

class CategoriesTableViewController: UITableViewController {
    let dataSource = CategoriesTableViewDataSource()
    let viewModel = CategoriesViewModel()
    let identifier = "Categories Storyboard Segue"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        navigationItem.title = "Categories"
        viewModel.delegate = self
        viewModel.loadCategories()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = dataSource.categories[indexPath.row]
                let categoryMealsTableViewController = segue.destination as! CategoryMealsTableViewController
                categoryMealsTableViewController.viewModel.category = category
            }
        }
    }
}

// MARK: - Delegation

extension CategoriesTableViewController: CategoriesViewModelDelegate {
    func loadedCategories(_ categories: [Category]) {
        DispatchQueue.main.async {
            self.dataSource.categories = categories
            self.tableView.reloadData()
        }
    }

    func loadFailed(_ networkingError: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(networkingError, retryHandler: {
                self.viewModel.loadCategories()
            })
        }
    }
}

protocol CategoriesViewModelDelegate: AnyObject {
    func loadedCategories(_ categories: [Category])
    func loadFailed(_ networkingError: NetworkingError)
}
