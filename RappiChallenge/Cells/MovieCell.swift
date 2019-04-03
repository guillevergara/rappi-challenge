//
//  MovieCell.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage:UIImageView!
    
    func configure(movie: Movie){
        
        movieImage.kf.indicatorType = .activity
        let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.posterPath ?? "")")
        movieImage.kf.setImage(with: url, placeholder: nil)
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
    }
}
