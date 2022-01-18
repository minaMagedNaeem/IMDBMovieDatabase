//
//  Movie.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class Movie: Codable {
    let posterPath: String?
    let overview: String
    let id: Int
    let originalTitle: String
    let voteAverage: Double
    let releaseDate: String
    let popularity: Double
    var favourite: Bool = false
    
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
}
