//
//  String+Titlized.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/26/21.
//

import Foundation

// MARK: - Titlize String

extension String {
    // Format any `String` as a title.
    func titlized() -> String {
        let title = self.capitalized
        return title.replacingOccurrences(of: "And", with: "&")
    }
}
