import Foundation

// MARK: - Categories
struct Categories: Decodable {
    let all: [Category]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Category Sorting
        let all = try container.decode([Category].self, forKey: .all)
        self.all = all.sorted(by: { $0.name < $1.name })
    }
    
    enum CodingKeys: String, CodingKey {
        case all = "categories"
    }
}

// MARK: - Category
struct Category: Decodable {
    let name: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Name Formatting
        let name = try container.decode(String.self, forKey: .name)
        self.name = name.formatted(as: .name)
    }

    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
