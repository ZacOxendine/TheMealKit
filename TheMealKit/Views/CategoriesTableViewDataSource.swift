import UIKit

class CategoriesTableViewDataSource: NSObject, UITableViewDataSource {
    let identifier = "Categories Table View Cell"
    var categories = [Category]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}
