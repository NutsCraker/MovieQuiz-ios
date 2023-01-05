//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Alexander Farizanov on 05.01.2023.
//

import Foundation
import XCTest

@testable import MovieQuiz

final class MovieQuizControllerProtocolMock: MovieQuizViewControllerProtocol {
  func showLoadingIndicator() {
    }
    
    func hideLoadingIndicator() {
    }
    
    func showNetworkError(message: String) {
    }
    
    func show(quiz step: QuizStepViewModel) {
    }
    
    func show(quiz result: QuizResultsViewModel) {
    }
    
    func highlightImageBorder(isCorrect: Bool) {
    
    }
 }

class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizControllerProtocolMock()
        let presenter = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Text Test", correctAnswer: true)
        let viewModel = presenter.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Text Test")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
