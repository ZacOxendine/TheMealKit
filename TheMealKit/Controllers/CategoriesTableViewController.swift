//
//  CategoriesTableViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    let categoriesModel = CategoriesModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = "Categories"
        categoriesModel.categoriesModelDelegate = self
        categoriesModel.loadCategories()
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesModel.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoriesModel.cellIdentifier, for: indexPath)
        cell.textLabel?.text = categoriesModel.categories[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == categoriesModel.segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let categoryMealsTableViewController = segue.destination as! CategoryMealsTableViewController
                categoryMealsTableViewController.categoryMealsModel.category = categoriesModel.categories[indexPath.row].name
            }
        }
    }
}

// MARK: - Delegation

extension CategoriesTableViewController: CategoriesModelDelegate {
    func loadedCategories(_ categories: [Category]) {
        DispatchQueue.main.async {
            self.categoriesModel.categories = categories
            self.tableView.reloadData()
        }
    }

    func loadFailed(_ networkingError: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(networkingError, retryHandler: {
                self.categoriesModel.loadCategories()
            })
        }
    }
}
