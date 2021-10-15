import Foundation

// MARK: - String Formatting

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
