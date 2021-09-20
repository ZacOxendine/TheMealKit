//
//  CategoryMealsTableViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class CategoryMealsTableViewController: UITableViewController {
    let cellIdentifier = "Category Meal Table View Cell"
    let segueIdentifier = "Category Meal Storyboard Segue"
    let theMealDB = TheMealDB()
    var categoryName = String()
    var categoryMeals = [CategoryMeal]() {
        didSet { categoryMeals.sort(by: { $0.name < $1.name }) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = categoryName
        theMealDB.request(.meals(by: categoryName), then: { (categoryMeals: CategoryMeals) in
            self.categoryMeals = categoryMeals.all
            DispatchQueue.main.async { self.tableView.reloadData() }
        })
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMeals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = categoryMeals[indexPath.row].name.titlized()
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealViewController = segue.destination as! MealViewController
                mealViewController.id = categoryMeals[indexPath.row].id
            }
        }
    }
}
