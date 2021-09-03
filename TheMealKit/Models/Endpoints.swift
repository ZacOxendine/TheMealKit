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
    let host = "www.themealdb.com"
    let pathBase = "/api/json/v1/1/"
    var pathEndpoint: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    // Categories Endpoint
    static func categories() -> Self {
        Endpoint(pathEndpoint: "categories.php")
    }

    // Filter Meals by Category Endpoint
    static func meals(by category: String) -> Self {
        Endpoint(
            pathEndpoint: "filter.php",
            queryItems: [URLQueryItem(name: "c", value: category)]
        )
    }

    // Lookup Meal by ID Endpoint
    static func meal(by id: String) -> Self {
        Endpoint(
            pathEndpoint: "lookup.php",
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
        urlComponents.path = pathBase + pathEndpoint
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { fatalError("invalid URL") }
        return url
    }
}
