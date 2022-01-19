//
//  MoviesListRepo.swift
//  IMDBMovieDatabaseTests
//
//  Created by Mina Maged on 1/18/22.
//

import Foundation
@testable import IMDBMovieDatabase

class TestMoviesListRepo: MoviesRepo {
    
    var movies: [Movie] = []
    
    func getMovies() -> [Movie] {
        return self.movies
    }
    
    func storeMovies(movies: [Movie]) {
        self.movies = movies
    }
    
    func filterMovies(favourite: Bool) -> [Movie] {
        return movies.filter({ $0.favourite == favourite})
    }
    
    func updateMovie(movie: Movie) {
        if let index = self.movies.firstIndex(where: { $0.id == movie.id}) {
            self.movies[index] = movie
        }
    }
}
