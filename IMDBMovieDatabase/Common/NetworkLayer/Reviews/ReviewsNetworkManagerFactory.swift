//
//  ReviewsNetworkManagerFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class ReviewsNetworkManagerFactory {
    class func getNetworkManager(isTesting: Bool) -> ReviewsNetworkManager {
        //if isTesting {
            
        //} else {
            return MainReviewsNetworkManager()
        //}
    }
}
