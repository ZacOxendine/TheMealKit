//
//  String+Helpers.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 8/26/21.
//

import UIKit

extension String {
    func titlized() -> String {
        let title = self.capitalized
        return title.replacingOccurrences(of: "And", with: "&")
    }
}
