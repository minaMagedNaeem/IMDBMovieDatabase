//
//  MoviesNetworkManagerFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MoviesNetworkManagerFactory {
    class func getNetworkManager() -> MoviesNetworkManager {
        //if isTesting {
            
        //} else {
            return MainMoviesNetworkManager()
        //}
    }
}
