//
//  MoviesNetworkManager.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class MainMoviesNetworkManager: MoviesNetworkManager {
    func getMovies(page: Int, completion: @escaping ((NetworkError?, [Movie]?) -> Void)) {
        if !Connectivity.isConnectedToInternet() {
            completion(.noInternet, nil)
            return
        }
        
        imdbMoviesProvider.request(.getMovies(page: page)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON() as? [String:Any]
                    let moviesData = try JSONSerialization.data(withJSONObject: json?["results"] as Any, options: .prettyPrinted)
                    let movies = try JSONDecoder().decode([Movie].self, from: moviesData)
                        
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
}
