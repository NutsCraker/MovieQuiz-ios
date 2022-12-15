//
//  NetworkErrors.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 15.12.2022.
//

import Foundation

protocol LocalizedError : Error {
    var errorDescription: String { get }
}

// MARK: - NetworkError
enum NetworkError: Error {
    
    case serverError
    case internetError
    case errorDecode
}
/*
// MARK: - extension NetworkError conform LocalizedError
extension NetworkError: LocalizedError {
    
        var errorDescription: String {
            switch self {
            case .serverError:
                return constants.ErrorMessage.serverError
            case .internetError:
                return ErrorMessage.internetError
            case .errorDecode:
                return ErrorMessage.eroorDecode
            }
        }
    }
*/
