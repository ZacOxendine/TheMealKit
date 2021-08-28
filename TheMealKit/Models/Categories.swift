//
//  Categories.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let all: [Category]

    enum CodingKeys: String, CodingKey {
        case all = "categories"
    }
}

// MARK: - Category
struct Category: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
