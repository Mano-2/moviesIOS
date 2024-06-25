//
//  DetailViewController.swift
//  moviesApp
//
//  Created by Manar Morabit on 8.06.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    
    
    var movie: Movie? {
           didSet {
               if isViewLoaded {
                   updateUI()
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if movie != nil {
                    updateUI()
            
                }
        
        if let movieId = movie?.id, let favoriteMovie = RealmManager.shared.fetchFavoriteMovie(by: movieId) {
                   movie?.isFavorite = favoriteMovie.isFavorite
               }
    }
    private func updateUI() {
           if let movie = movie {
               loadMoviePoster(movie: movie)
               updateFavoriteButton()

               movieTitle.text = movie.name
               descriptionText.text = movie.description
           }
       }
    

  
    private func updateFavoriteButton() {
         let favoriteImage = movie?.isFavorite == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(toggleFavoriteStatus))
     }
    
    @objc private func toggleFavoriteStatus() {
         guard var movie = movie else { return }
         movie.isFavorite.toggle()
         RealmManager.shared.toggleFavorite(movie: movie)
         self.movie = movie
         updateFavoriteButton()
     }
    
    private func loadMoviePoster(movie: Movie) {
    movie.posterUrl(posterPath: movie.posterPath) { [weak self] imageData in
          
            
            if let data = imageData, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.moviePoster.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.moviePoster.image = UIImage(named: "placeholder_image")
                }
            }
        }
    }
    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    
     
    */

}
