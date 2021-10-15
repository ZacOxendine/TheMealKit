import UIKit

class CategoryMealsTableViewDataSource: NSObject, UITableViewDataSource {
    let identifier = "Category Meals Table View Cell"
    var categoryMeals = [CategoryMeal]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMeals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = categoryMeals[indexPath.row].name
        return cell
    }
}

