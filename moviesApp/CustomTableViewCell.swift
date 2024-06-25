//
//  CustomTableViewCell.swift
//  moviesApp
//
//  Created by Manar Morabit on 31.05.2024.
//

import UIKit
import Alamofire

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    
    
    
    
    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        iconImageView.image = nil
//        label.text = ""
//    }
//    
//    func configure(with movie: Movie) {
//        label.text = movie.name
//        let posterPath = movie.posterPath ?? ""
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")  else  {return}
//        
//        
//        AF.request(url).responseData { response in
//                    switch response.result {
//                    case .success(let data):
//                        // If image data is downloaded successfully, set it to the image view
//                        
//                        if let image = UIImage(data: data) {
//                            self.iconImageView.image = image
//                        }
//                    case .failure(let error):
//                        print("Error loading image: \(error)")
//                    }
//                }
//    }
}
