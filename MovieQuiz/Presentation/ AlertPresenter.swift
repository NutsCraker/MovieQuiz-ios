//
//   AlertPresenter.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 04.12.2022.
//
import UIKit

struct AlertPresenter {

    weak var delegate: AlertPresenterDelegate?
    
    func show(result: AlertModel) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "ResultAlert"
        let action = UIAlertAction(title: result.buttonText, style: .default, handler: result.completion)

        alert.addAction(action)
        delegate?.didPresentAlert(alert: alert)
       
        
    }
    
    
}
