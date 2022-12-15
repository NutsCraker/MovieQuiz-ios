//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 02.12.2022.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol {

  
    // MARK: - Private Properties
    
    private let moviesLoader: MoviesLoading
    
    private var movies: [MostPopularMovie] = []
    
//    private var question: [QuizQuestion] = [
//        QuizQuestion(image: "The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
//        QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
//        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
//        QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
//        QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
//    ]
    
    // MARK: - Properties
    
    weak var delegate: QuestionFactoryDelegate?
    
    // MARK: - Init
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate? ) {
           self.moviesLoader = moviesLoader
           self.delegate = delegate
       }
    
    // MARK: - Methods
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data()
            
            do {
                imageData =  try Data(contentsOf: movie.resizedImageURL)
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didFailToLoadData(with: NetworkError.serverError)
                }
            }
            
            let randomRating = [5, 6, 7, 8].randomElement() ?? 7
            
            let rating = Float(movie.rating) ?? 0
            let text = "Рейтинг этого фильма больше чем \(Int(randomRating))?"
            
            let correctAnswer = rating > Float(randomRating)
            
            let question = QuizQuestion(image: imageData, text: text, correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }

    func loadData() {
        moviesLoader.loadMovies { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(_):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.delegate?.didFailToLoadData(with: NetworkError.serverError)
                    }
                }
            }
        }
    }
}
