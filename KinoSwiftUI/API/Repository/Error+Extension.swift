//
//  Error+Extension.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

enum NetworkError: Error {
    case noConnection
    case invalidServerResponse
    case custom
    case parsingFailure
}


extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return NSLocalizedString("No Internet connection available.", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Invalid server response.", comment: "")
        case .custom:
            return NSLocalizedString("An error has occurred.", comment: "")
        case .parsingFailure:
            return NSLocalizedString("A data parsing error had occured. Please try again", comment: "")
        }
    }
}
