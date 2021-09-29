//
//  Errors.swift
//  TheMealKit
//
//  Created by Zachary Oxendine on 9/27/21.
//

import Foundation

// MARK: - Errors

enum ErrorCategory {
    case notRetryable
    case retryable
}

protocol CategorizedError: Error {
    var category: ErrorCategory { get }
}

enum NetworkingError: LocalizedError {
    case deviceOffline
    case invalidURL
    case missingData
    case undecodedData

    var errorDescription: String? {
        switch self {
        case .deviceOffline:
            return NSLocalizedString(
                """
                Your device is offline.
                Please try again later.
                """,
                comment: ""
            )
        case .invalidURL:
            return NSLocalizedString(
                """
                TheMealDB URL is invalid.
                Please report this issue.
                """,
                comment: ""
            )
        case .missingData:
            return NSLocalizedString(
                """
                TheMealDB data is missing.
                Please report this issue.
                """,
                comment: ""
            )
        case .undecodedData:
            return NSLocalizedString(
                """
                TheMealDB data was undecodable.
                Please report this issue.
                """,
                comment: ""
            )
        }
    }
}

extension NetworkingError: CategorizedError {
    var category: ErrorCategory {
        switch self {
        case .deviceOffline:
            return .retryable
        case .invalidURL, .missingData, .undecodedData:
            return .notRetryable
        }
    }
}

extension Error {
    func resolveCategory() -> ErrorCategory {
        guard let categorized = self as? CategorizedError else {
            return .notRetryable
        }

        return categorized.category
    }
}
