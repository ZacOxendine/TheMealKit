//
//  CategoryMealsTableViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class CategoryMealsTableViewController: UITableViewController {
    let categoryMealsModel = CategoryMealsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = categoryMealsModel.category
        categoryMealsModel.categoryMealsModelDelegate = self
        categoryMealsModel.loadCategoryMeals()
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMealsModel.categoryMeals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryMealsModel.cellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = categoryMealsModel.categoryMeals[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == categoryMealsModel.segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealViewController = segue.destination as! IDMealsViewController
                mealViewController.idMealsModel.id = categoryMealsModel.categoryMeals[indexPath.row].id
            }
        }
    }
}

// MARK: - Delegation

extension CategoryMealsTableViewController: CategoryMealsModelDelegate {
    func loadedCategoryMeals(_ meals: [CategoryMeal]) {
        DispatchQueue.main.async {
            self.categoryMealsModel.categoryMeals = meals
            self.tableView.reloadData()
        }
    }

    func loadFailed(_ error: NetworkingError) {
        DispatchQueue.main.async {
            self.handle(error, retryHandler: {
                self.categoryMealsModel.loadCategoryMeals()
            })
        }
    }
}
