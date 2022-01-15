//
//  MovieTableViewCell.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImageView.kf.indicatorType = .activity
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            self.bind(movie: movie)
        }
    }
    
    var onPressFavourites: ((Int) -> Void)?
    
    private func bind(movie: Movie) {
        if let posterPath = movie.posterPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w92/\(posterPath)") {
            movieImageView.kf.setImage(with: imageUrl)
        }
        
        nameLabel.text = movie.originalTitle
        descriptionLabel.text = movie.overview
        
        self.bindFavouriteButton(isMovieFavourite: movie.favourite)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToFavouritesPressed(_ sender: Any) {
        guard let movie = movie else { return }
        
        self.onPressFavourites?(movie.id)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView?.image = nil
        self.nameLabel.text = ""
        self.descriptionLabel.text = ""
    }
}
