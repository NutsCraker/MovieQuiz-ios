//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Alexander Farizanov on 15.12.2022.
//

import Foundation
struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
   
    var resizedImageURL: URL {
        let urlString = imageURL.absoluteString
        let imageURLString = urlString.components(separatedBy: "._")[0] + "._V0_UX600_.jpg"
        guard let newUrl = URL(string: imageURLString) else {
            return imageURL
        }
        
        return newUrl
    }
    private enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
        
    }
}
