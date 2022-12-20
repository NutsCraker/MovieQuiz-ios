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
    case somethingWrong
}
extension NetworkError: LocalizedError {
    
        var errorDescription: String {
            switch self {
            case .serverError:
                return "Ошибка сервера"
            case .internetError:
                return "Ошибка сети"
            case .errorDecode:
                return "Ошибка преобразования данных"
            case .somethingWrong:
                return "Неверный ответ от сервера"
            }
        }
    }
