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
