//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 05.01.2023.
//

import Foundation

protocol MovieQuizViewControllerProtocol {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func show(quiz step: QuizStepViewModel)

    func showAnswerResult(isCorrect: Bool)
   
}
