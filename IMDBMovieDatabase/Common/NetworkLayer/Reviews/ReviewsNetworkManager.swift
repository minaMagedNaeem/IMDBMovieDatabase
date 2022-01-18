//
//  ReviewsNetworkManager.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/16/22.
//

import Foundation

protocol ReviewsNetworkManager {
    func getReviews(movieId: Int, page: Int, completion: @escaping ((NetworkError?, [Review]?) -> Void))
    
    func rateMovie(movieId: Int, rate: Int, completion: @escaping ((_ success: Bool) -> Void))
}
