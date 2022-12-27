//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 27.12.2022.
//
import UIKit
protocol AlertPresenterDelegate: AnyObject {
    func didPresentAlert(alert: UIAlertController?)
}
