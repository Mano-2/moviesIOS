//
//  MovieManager.swift
//  moviesApp
//
//  Created by Manar Morabit on 1.06.2024.
//

import Foundation
import Alamofire

struct MovieService {
    
    func getPopularMovies(page: Int = 1, pageSize: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        APIManager.shared.request(endpoint: "/movie/popular", parameters: ["page": page]) { result in
            switch result {
            case .success(let data):
                do {
                    let movieResults = try JSONDecoder().decode(MovieResults.self, from: data)
                    completion(.success(movieResults.results))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    func searchMovies(searchTerm: String, completion: @escaping (Result<[Movie], Error>)-> Void){
        APIManager.shared.request(endpoint:"/search/movie", parameters: ["query":searchTerm]) { result in
            switch result {
            case .success(let data):
                do{
                    let movieResults = try JSONDecoder().decode(MovieResults.self , from: data)
                    completion(.success(movieResults.results))
                }
                catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    // Example of a POST request method
    //    func postMovieReview(movieId: Int, review: String, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
    //        let parameters: Parameters = [
    //            "movie_id": movieId,
    //            "review": review
    //        ]
    //
    //        APIManager.shared.request(endpoint: "/movie/\(movieId)/reviews", method: .post, parameters: parameters) { result in
    //            switch result {
    //            case .success(let data):
    //                do {
    //                    let reviewResponse = try JSONDecoder().decode(ReviewResponse.self, from: data)
    //                    completion(.success(reviewResponse))
    //                } catch let error {
    //                    completion(.failure(error))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    
    
    
    //struct ReviewResponse: Codable {
    //    let id: Int
    //    let review: String
    //    // Add other response fields as needed
    //}
}
