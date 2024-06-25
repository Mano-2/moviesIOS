//
//  RealmManager.swift
//  moviesApp
//
//  Created by Manar Morabit on 19.06.2024.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private let realm = try! Realm()

    func toggleFavorite(movie: Movie) {
        _ = FavoriteMovie(movie: movie)
        try! realm.write {
            if let existingMovie = realm.object(ofType: FavoriteMovie.self, forPrimaryKey: movie.id) {
                            existingMovie.isFavorite.toggle()
                            if !existingMovie.isFavorite {
                                realm.delete(existingMovie)
                            }
                        } else {
                            let favoriteMovie = FavoriteMovie(movie: movie)
                            favoriteMovie.isFavorite = true
                            realm.add(favoriteMovie)
                        }
        }
    }

    func getFavoriteMovies() -> [Movie] {
        let movieObjects = realm.objects(FavoriteMovie.self).filter("isFavorite == true")
        return movieObjects.map { $0.toMovie() }
    }
    
    func fetchFavoriteMovie(by id: Int) -> FavoriteMovie? {
           return realm.object(ofType: FavoriteMovie.self, forPrimaryKey: id)
       }
}
