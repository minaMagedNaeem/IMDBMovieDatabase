//
//  ReviewsRepo.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

protocol ReviewsRepo {
    func getReviews() -> [Review]
    
    func storeReviews(reviews: [Review])
}
