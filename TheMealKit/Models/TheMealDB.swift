//
//  TheMealDB.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/12/21.
//

import Foundation

class TheMealDB {
    // Request & Decode Data from Endpoints
    func request<T: Decodable>(_ endpoint: Endpoint, then completionHandler: @escaping (T) -> Void) {
        if let url = endpoint.url {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else { fatalError(error?.localizedDescription ?? "unknown error") } // implement error handling, remove fatalError
                if let decodedData = try? JSONDecoder().decode(T.self, from: data) { completionHandler(decodedData) }
            }.resume()
        }
    }
}
