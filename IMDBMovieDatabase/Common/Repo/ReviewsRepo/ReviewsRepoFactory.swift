//
//  ReviewsRepoFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class ReviewsRepoFactory {
    class func getRepo(isTesting: Bool = false) -> ReviewsRepo {
        //if isTesting {
            
        //} else {
            return MainReviewsRepo()
        //}
    }
}
