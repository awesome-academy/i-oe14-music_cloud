//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation

struct ErrorMessages {
    // Error message
    static let networkError = "Network Error"
    static let error = "Error"
    static let unexpectedError = "Unexpected Error"
    static let redirectionError = "It was transferred to a different URL. I'm sorry for causing you trouble"
    static let clientError = "An error occurred on the application side. Please try again later!"
    static let serverError = "A server error occurred. Please try again later!"
    static let unofficalError = "An error occurred. Please try again later!"
}

enum BaseError: Error {
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiFailure(error: ErrorResponse?)
    
    public var errorMessage: String? {
        switch self {
        case .networkError:
            return ErrorMessages.networkError
        case .httpError(httpCode: let code):
            return getHttpErrorMessage(httpCode: code)
        case .apiFailure(error: let error):
            if let error = error {
                return error.message
            }
            return ErrorMessages.error
        default:
            return ErrorMessages.unexpectedError
        }
    }
    
    private func getHttpErrorMessage(httpCode: Int) -> String? {
        switch HTTPStatusCode(rawValue: httpCode)?.responseType {
        case .redirection?:
            return ErrorMessages.redirectionError
        case .clientError?:
            return ErrorMessages.clientError
        case .serverError?:
            return ErrorMessages.serverError
        default:
            return ErrorMessages.unofficalError
        }
    }
}
