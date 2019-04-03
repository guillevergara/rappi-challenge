//
//  DetailViewController.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage:UIImageView!
    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var movieDescription:UILabel!
    
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let movie = movie {
            movieImage.kf.indicatorType = .activity
            let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.posterPath ?? "")")
            movieImage.kf.setImage(with: url, placeholder: nil)
            
            self.title = movie.isMovie ? movie.title : movie.name
            movieDescription.text = movie.overview
        }
    }


}

