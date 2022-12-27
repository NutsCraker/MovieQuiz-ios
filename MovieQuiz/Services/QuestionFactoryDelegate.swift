//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 04.12.2022.
//
import UIKit

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error) 
}
