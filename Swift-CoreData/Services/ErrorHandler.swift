//
//  ErrorHandler.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import Foundation

enum ErrorHandler {
    // API errors
    case apiEndpointError
    case parsingError
    case invalidUrlError
    // UI errors
    case imageDoesNotExist
}

extension ErrorHandler: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiEndpointError:
            return NSLocalizedString("API endpoint does not exist.", comment: "Endpoint error")
        case .parsingError:
            return NSLocalizedString("Data recieved is not decodable/parseable.", comment: "Parsing error")
        case .invalidUrlError:
            return NSLocalizedString("Invalid URL check for typo.", comment: "Invalid URL error")
        case .imageDoesNotExist:
            return NSLocalizedString("Image does not exist.", comment: "Image does not exist.")
        }
    }
}
