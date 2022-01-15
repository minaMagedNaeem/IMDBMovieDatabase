//
//  MovieDetailsHeader.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/15/22.
//

import UIKit
import Cosmos
import Kingfisher

class MovieDetailsHeader: UIView {

    @IBOutlet weak var movieImage: UIImageView! {
        didSet {
            movieImage.kf.indicatorType = .activity
        }
    }
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var ratingView: CosmosView! {
        didSet {
            self.setupRatingView()
        }
    }
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            
            if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w780/\(posterPath)") {
                movieImage.kf.setImage(with: imageUrl)
            }
            
            movieName.text = movie.originalTitle
            movieDescription.text = movie.overview
            releaseDate.text = "Release data: \(movie.releaseDate)"
            rating.text = "Average Rating: \(movie.voteAverage)"
            popularity.text = "Popularity: \(movie.popularity)"
        }
    }
    
    private func setupRatingView() {
        ratingView.didFinishTouchingCosmos = { rating in
            print(rating)
        }
    }
    
    @IBAction func addToFavouritesPressed(_ sender: Any) {
    }
    
}
