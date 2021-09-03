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
    let theMealDB = TheMealDB()
    var category = String()
    var meals = [CategoryMeal]() {
        didSet { meals.sort(by: { $0.name < $1.name }) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = category
        theMealDB.requestMeals(by: category, completion: { meals in
            if let meals = meals { self.meals = meals.all }
            DispatchQueue.main.async { self.tableView.reloadData() }
        })
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = meals[indexPath.row].name.titlized()
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealViewController = segue.destination as! MealViewController
                mealViewController.id = meals[indexPath.row].id
            }
        }
    }
}
