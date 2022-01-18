//
//  ReviewsTableViewCell.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/16/22.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var reviewerImageView: UIImageView!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - Global Variables
    var review: Review? {
        didSet {
            guard let review = self.review else { return }
            self.bind(review: review)
        }
    }

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewerImageView.kf.indicatorType = .activity
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private Methods
    private func bind(review: Review) {
        if let avatarPath = review.authorDetails?.avatarPath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w92/\(avatarPath)") {
            reviewerImageView.kf.setImage(with: imageUrl)
        }
        
        reviewerNameLabel.text = review.authorDetails?.name
        reviewLabel.text = review.content
        
        if let rating = review.authorDetails?.rating {
            ratingLabel.text = "Rate: \(rating)"
        } else {
            ratingLabel.text = ""
        }
    }
}
