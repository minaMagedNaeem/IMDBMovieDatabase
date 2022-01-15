//
//  MoviesRepo.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/15/22.
//

import Foundation
import RealmSwift

class MoviesRepo {
    
    let realm = try? Realm()
    
    func getMovies() -> [Movie] {
        if let results = realm?.objects(StorableMovie.self) {
            return Array(results.map({ $0.domainMovie }))
        }
        return []
    }
    
    func storeMovies(movies: [Movie]) {
        let storableMovies = movies.map({$0.storableMovie})
        try? realm?.write {
            realm?.add(storableMovies, update: .modified)
        }
    }
    
    func filterMovies(favourite: Bool) -> [Movie] {
        if let results = realm?.objects(StorableMovie.self).where({$0.favourite == favourite}) {
            return Array(results.map({ $0.domainMovie }))
        }
        return []
    }
    
    func updateMovie(movie: Movie) {
        let storableMovie = movie.storableMovie
        try? realm?.write {
            realm?.add(storableMovie, update: .modified)
        }
    }
}
