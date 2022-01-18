//
//  MainReviewsNetworkManager.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/16/22.
//

import Foundation

class MainReviewsNetworkManager: ReviewsNetworkManager {
    func getReviews(movieId: Int, page: Int, completion: @escaping ((NetworkError?, [Review]?) -> Void)) {
        if !Connectivity.isConnectedToInternet() {
            completion(.noInternet, nil)
            return
        }
        
        imdbMoviesProvider.request(.getReviews(movieId: movieId, page: page)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON() as? [String:Any]
                    let moviesData = try JSONSerialization.data(withJSONObject: json?["results"] as Any, options: .prettyPrinted)
                    let movies = try JSONDecoder().decode([Review].self, from: moviesData)
                        
                    completion(nil, movies)
                }
                catch(let error) {
                    print(error.localizedDescription)
                    completion(.decodeError, nil)
                }
            case .failure(let error):
                completion(.networkError(errorCode: error.response?.statusCode ?? 0), nil)
            }
        }
    }
    
    func rateMovie(movieId: Int, rate: Int, completion: @escaping ((Bool) -> Void)) {
        
        if TMDBKeysManager.getGuestAPIKey() != nil {
            self.runRateMovieRequest(movieId: movieId, rate: rate, completion: completion)
        } else {
            self.registerGuestSessionId {[weak self] (success) in
                if success {
                    self?.runRateMovieRequest(movieId: movieId, rate: rate, completion: completion)
                }
            }
        }
    }
    
    private func runRateMovieRequest(movieId: Int, rate: Int, completion: @escaping ((Bool) -> Void)) {
        imdbMoviesProvider.request(.rateMovie(movieId: movieId, rate: rate)) { (result) in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    private func registerGuestSessionId(completion: @escaping ((Bool) -> Void)) {
        imdbMoviesProvider.request(.registerGuestSession) { (result) in
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() as? [String:Any],
                   let guestSessionId = json["guest_session_id"] as? String {
                    TMDBKeysManager.setGuestAPIKey(key: guestSessionId)
                    completion(true)
                }
            case .failure:
                completion(false)
            }
        }
    }
    
}
