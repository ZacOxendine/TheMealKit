//
//  Endpoints.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

// MARK: - Endpoints

struct Endpoint {
    // URL Components
    let scheme = "https"
    let host = "www.themealdb.com"
    let basePath = "/api/json/v1/1/"
    let subpath: String
    let urlQueryItems: [URLQueryItem]?
}

extension Endpoint {
    // Categories Endpoint
    static func categories() -> Self {
        Endpoint(
            subpath: "categories.php",
            urlQueryItems: nil
        )
    }

    // Filter Meals by Category Endpoint
    static func meals(from category: String) -> Self {
        Endpoint(
            subpath: "filter.php",
            urlQueryItems: [
                URLQueryItem(name: "c", value: category)
            ]
        )
    }

    // Lookup Meal by ID Endpoint
    static func meals(with id: String) -> Self {
        Endpoint(
            subpath: "lookup.php",
            urlQueryItems: [
                URLQueryItem(name: "i", value: id)
            ]
        )
    }
}

extension Endpoint {
    // URL Builder
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = basePath + subpath
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
    }
}
