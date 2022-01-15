//
//  Movie.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
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

class Movie: Codable {
    let posterPath: String?
    let overview: String
    let id: Int
    let originalTitle: String
    let voteAverage: Double
    let releaseDate: String
    let popularity: Double
    var favourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case id
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case popularity
    }

    init(id: Int,
         posterPath: String?,
         overview: String,
         originalTitle: String,
         voteAverage: Double,
         releaseDate: String,
         popularity: Double,
         favourite: Bool) {
        self.posterPath = posterPath
        self.overview = overview
        self.id = id
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.favourite = favourite
    }
    
    var storableMovie: StorableMovie {
        return StorableMovie.init(id: id,
                                  originalTitle: originalTitle,
                                  posterPath: posterPath,
                                  voteAverage: voteAverage,
                                  overview: overview,
                                  releaseDate: releaseDate,
                                  popularity: popularity,
                                  favourite: favourite)
    }
}
