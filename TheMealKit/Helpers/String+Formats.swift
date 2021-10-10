//
//  String+Formats.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/26/21.
//

import Foundation

// MARK: - String Formats

enum Format {
    case name
    case id
    case instructions
    case ingredient
    case measure
}

extension String {
    func formatted(as format: Format) -> Self {
        switch format {
        case .name, .ingredient:
            var name = self
            name = name.capitalized
            name = name.replacingOccurrences(of: "And", with: "&")
            name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            return name
        case .id, .instructions:
            var instructions = self
            instructions = instructions.trimmingCharacters(in: .whitespacesAndNewlines)
            return instructions
        case .measure:
            var measure = self
            measure = measure.lowercased()
            measure = measure.trimmingCharacters(in: .whitespacesAndNewlines)
            return measure
        }
    }
}
