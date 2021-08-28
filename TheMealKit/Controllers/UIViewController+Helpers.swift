//
//  UIViewController+Helpers.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/26/21.
//

import UIKit

extension UIViewController {
    func formatTitle(of name: String?) -> String? {
        var title: String?

        if var format = name {
            format = format.trimmingCharacters(in: .whitespacesAndNewlines)
            if !format.isEmpty {
                format = format.capitalized
                format = format.replacingOccurrences(of: "And", with: "&")
                title = format
            }
        }

        return title
    }

    func formatDescription(of text: String?) -> String? {
        var description: String?

        if var format = text {
            format = format.trimmingCharacters(in: .whitespacesAndNewlines)
            if !format.isEmpty {
                format = format.lowercased()
                description = format
            }
        }

        return description
    }

    func formatList(of keys: [String?], with values: [String?] ) -> String? {
        var list: String?

        for i in keys.indices {
            guard let key = formatTitle(of: keys[i]) else { continue }
            guard let value = formatDescription(of: values[i]) else { continue }
            let item = "• \(key) (\(value))\n"
            if !key.isEmpty && !value.isEmpty {
                if var format = list {
                    format += item
                    list = format
                } else {
                    list = item
                }
            }
        }

        return list?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
