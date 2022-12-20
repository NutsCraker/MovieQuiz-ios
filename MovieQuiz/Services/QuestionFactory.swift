//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 02.12.2022.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol {

  
    // MARK: - Private Properties
    
    private let moviesLoader: MoviesLoading
    private var movies: [MostPopularMovie] = []
        
    // MARK: - Properties
    
    private weak var delegate: QuestionFactoryDelegate?
    
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
                    self.delegate?.didFailToLoadData(with: NetworkError.errorDecode)
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
                    if mostPopularMovies.errorMessage != ""{ // Если не пустое поле - то значит все равно что --то нитак!
                        self.delegate?.didFailToLoadData(with: NetworkError.somethingWrong)
                    }
                    else
                    {
                        self.movies = mostPopularMovies.items
                        self.delegate?.didLoadDataFromServer()
                    }
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
