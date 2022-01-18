//
//  MoviesNetworkManagerFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MoviesNetworkManagerFactory {
    class func getNetworkManager(isTesting: Bool = false) -> MoviesNetworkManager {
        //if isTesting {
            
        //} else {
            return MainMoviesNetworkManager()
        //}
    }
}
