//
//  FavoriteViewController.swift
//  moviesApp
//
//  Created by Manar Morabit on 25.06.2024.
//

import UIKit
import RealmSwift


class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var favoriteMovies: [FavoriteMovie] = []

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self // Optional: if you want to handle item selection
                
                fetchFavoriteMovies()
    
    }
    
    private func fetchFavoriteMovies() {
         do {
             let realm = try Realm()
             let movies = realm.objects(FavoriteMovie.self)
             favoriteMovies = Array(movies)
             collectionView.reloadData()
         } catch {
             print("Error fetching favorite movies: \(error)")
         }
     }
    

 

}
extension FavoriteViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
              
              let movie = favoriteMovies[indexPath.item]
              cell.configure(with: movie.toMovie())
              
              return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    
}
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection if needed
    }
}
