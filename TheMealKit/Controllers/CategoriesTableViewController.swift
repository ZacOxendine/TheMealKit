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
    let networkingService = NetworkingService()
    var categories = [Category]() {
        didSet { categories.sort(by: { $0.name < $1.name }) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = "Categories"
        loadCategories()
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mealsTableViewController = segue.destination as! MealsTableViewController
                mealsTableViewController.category = categories[indexPath.row].name
            }
        }
    }

    // MARK: - Data Management

    func loadCategories() {
        typealias ResultAlias = Result<Categories, NetworkingError>
        networkingService.fetch(.categories(), handler: { [weak self] (result: ResultAlias) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.categories = categories.all
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.handle(error, retryHandler: {
                        self?.loadCategories()
                    })
                }
            }
        })
    }
}
