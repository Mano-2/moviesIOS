//
//  MovieCollectionViewCell.swift
//  moviesApp
//
//  Created by Manar Morabit on 25.06.2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.name
        
        // Set rating text with star symbol
                
        // Set rating icon based on rating value
      
        
        if let posterPath = movie.posterPath {
            // Load image asynchronously
            movie.posterUrl(posterPath: posterPath) { [weak self] data in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieImageView.image = image
                    }
                }
            }
        }
    }
}
