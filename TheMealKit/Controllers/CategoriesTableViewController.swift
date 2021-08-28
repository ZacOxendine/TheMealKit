//
//  CategoriesTableViewController.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    let cellIdentifier = "Category Table View Cell"
    let segueIdentifier = "Category Storyboard Segue"
    var categories: [Category]? {
        didSet {
            categories?.sort(by: { $0.name < $1.name })
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = "Categories"
        TheMealDB().requestCategories(completion: { self.categories = $0?.all })
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealsTableViewController = segue.destination as! MealsTableViewController
                mealsTableViewController.categoryName = categories?[indexPath.row].name
            }
        }
    }
}
