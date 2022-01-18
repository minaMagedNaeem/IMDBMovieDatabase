//
//  MoviesRepoFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MoviesRepoFactory {
    class func getRepo(isTesting: Bool = false) -> MoviesRepo {
        //if isTesting {
            
        //} else {
            return MainMoviesRepo()
        //}
    }
}
