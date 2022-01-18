//
//  MoviesRepo.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/15/22.
//

import Foundation

protocol MoviesRepo {
    func getMovies() -> [Movie]
    
    func storeMovies(movies: [Movie])
    
    func filterMovies(favourite: Bool) -> [Movie]
    
    func updateMovie(movie: Movie)
}
