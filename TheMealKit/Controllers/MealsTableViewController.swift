//
//  MealsTableViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class MealsTableViewController: UITableViewController {
    let cellIdentifier = "Meal Table View Cell"
    let segueIdentifier = "Meal Storyboard Segue"
    var categoryName: String? {
        didSet {
            TheMealDB().requestMeals(by: categoryName, completion: { self.categoryMeals = $0?.all })
        }
    }
    var categoryMeals: [CategoryMeal]? {
        didSet {
            categoryMeals?.sort(by: { $0.name < $1.name })
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = categoryName
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMeals?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = formatTitle(of: categoryMeals?[indexPath.row].name)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealViewController = segue.destination as! MealViewController
                mealViewController.mealID = categoryMeals?[indexPath.row].id
            }
        }
    }
}
