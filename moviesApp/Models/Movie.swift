//
//  movie.swift
//  moviesApp
//
//  Created by Manar Morabit on 31.05.2024.
//


import Foundation
import Alamofire

struct Movie: Codable {
    let id: Int  // API gives it as an Int
    let name: String?
    let language: String?
    let isAdult: Bool?
    let description: String?
    let posterPath: String?
    let backdropPath: String?
    let rating: Double?
    let releaseDate: String?
    var isFavorite: Bool = false // New property to track favorite status

    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case language = "original_language"
        case isAdult = "adult"
        case description = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
    
    // Function to construct the full URL for the poster image
    func posterUrl(posterPath: String?, completion: @escaping (Data?) -> Void) {
        guard let posterPath = posterPath else { return}
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        guard let url = URL(string: urlString) else {return}
        
        
        AF.request(url).responseData { response in
            switch response.result{
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
                
            }
        }
        
        
        
    }
    
}
struct MovieResults: Codable {
    let results: [Movie]
}
