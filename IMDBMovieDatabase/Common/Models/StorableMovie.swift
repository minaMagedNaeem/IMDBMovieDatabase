//
//  StorableMovie.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import RealmSwift

class StorableMovie: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var originalTitle: String = ""
    @Persisted var posterPath: String?
    @Persisted var voteAverage: Double = 0
    @Persisted var overview: String = ""
    @Persisted var favourite: Bool = false
    @Persisted var releaseDate: String
    @Persisted var popularity: Double
    
    var domainMovie: Movie {
        return Movie(id: id,
                     posterPath: posterPath,
                     overview: overview,
                     originalTitle: originalTitle,
                     voteAverage: voteAverage,
                     releaseDate: releaseDate,
                     popularity: popularity,
                     favourite: favourite)
    }
    
    init(id: Int,
         originalTitle: String,
         posterPath: String?,
         voteAverage: Double,
         overview: String,
         releaseDate: String,
         popularity: Double,
         favourite: Bool = false) {
        super.init()
        self.id = id
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.favourite = favourite
    }
    
    required override init() {
        super.init()
    }
}
