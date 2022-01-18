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

    // MARK: - IBOutlets
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
    
    // MARK: - Global Variables
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            
            self.bind(movie: movie)
        }
    }
    var onPressAddToFavourites: (() -> Void)?
    var onRating: ((Int) -> Void)?
    
    // MARK: - IBActions
    @IBAction func addToFavouritesPressed(_ sender: Any) {
        self.onPressAddToFavourites?()
    }
    
    // MARK: - Private Functions
    private func bind(movie: Movie) {
        if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w780/\(posterPath)") {
            movieImage.kf.setImage(with: imageUrl)
        }
        
        movieName.text = movie.originalTitle
        movieDescription.text = movie.overview
        releaseDate.text = "Release data: \(movie.releaseDate)"
        rating.text = "Average Rating: \(movie.voteAverage)"
        popularity.text = "Popularity: \(movie.popularity)"
        
        bindFavouriteButton(isMovieFavourite: movie.favourite)
    }
    
    private func setupRatingView() {
        ratingView.didFinishTouchingCosmos = {[weak self] rating in
            print(rating)
            
            let properRating: Int = min(1, max(Int(rating * 2), 10))
            
            self?.onRating?(properRating)
        }
    }
    
    private func bindFavouriteButton(isMovieFavourite: Bool) {
        if isMovieFavourite {
            self.addToFavouritesButton.tintColor = .systemOrange
            self.addToFavouritesButton.setTitle("Added to favourites", for: .normal)
        } else {
            self.addToFavouritesButton.tintColor = .systemGray
            self.addToFavouritesButton.setTitle("Add to favourites", for: .normal)
        }
    }
    
}
