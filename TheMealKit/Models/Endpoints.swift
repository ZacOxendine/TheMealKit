//
//  Endpoints.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

struct Endpoint {
    // URL Components
    let scheme = "https"
    var host: String
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    // Categories Endpoint
    static func categories() -> Self {
        Endpoint(
            host: "www.themealdb.com",
            path: "/api/json/v1/1/categories.php"
        )
    }

    // Filter Meals by Category Endpoint
    static func meals(by category: String) -> Self {
        Endpoint(
            host: "www.themealdb.com",
            path: "/api/json/v1/1/filter.php",
            queryItems: [URLQueryItem(name: "c", value: category)]
        )
    }

    // Lookup Meal by ID Endpoint
    static func meal(by id: String) -> Self {
        Endpoint(
            host: "www.themealdb.com",
            path: "/api/json/v1/1/lookup.php",
            queryItems: [URLQueryItem(name: "i", value: id)]
        )
    }
}

extension Endpoint {
    // URL Builder
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { fatalError("invalid URL") }
        return url
    }
}
