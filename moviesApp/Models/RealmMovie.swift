//
//  RealMovie.swift
//  moviesApp
//
//  Created by Manar Morabit on 19.06.2024.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String?
    @Persisted var language: String?
    @Persisted var isAdult: Bool?
    @Persisted var movieDescription: String?
    @Persisted var posterPath: String?
    @Persisted var backdropPath: String?
    @Persisted var rating: Double?
    @Persisted var releaseDate: String?
    @Persisted var isFavorite: Bool = false
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id
        self.name = movie.name ?? ""
        self.language = movie.language
        self.isAdult = movie.isAdult
        self.movieDescription = movie.description
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.rating = movie.rating
        self.releaseDate = movie.releaseDate
        self.isFavorite = movie.isFavorite
    }
    func toMovie() -> Movie {
          return Movie(id: id,
                       name: name,
                       language: language,
                       isAdult: isAdult,
                       description: description,
                       posterPath: posterPath,
                       backdropPath: backdropPath,
                       rating: rating,
                       releaseDate: releaseDate,
                       isFavorite: isFavorite)
      }
}
