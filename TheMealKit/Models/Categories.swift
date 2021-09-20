//
//  Categories.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Categories
struct Categories: Decodable {
    enum CodingKeys: String, CodingKey {
        case all = "categories"
    }

    let all: [Category]
}

// MARK: - Category
struct Category: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }

    let name: String
}
