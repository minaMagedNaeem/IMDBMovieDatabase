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
    
    init(id: Int,
         originalTitle: String,
         posterPath: String?,
         voteAverage: Double,
         overview: String,
         favourite: Bool = false) {
        super.init()
        self.id = id
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.overview = overview
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
    var favourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case id
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
    }

    init(id: Int,
         posterPath: String?,
         overview: String,
         originalTitle: String,
         voteAverage: Double) {
        self.posterPath = posterPath
        self.overview = overview
        self.id = id
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
    }
    
    func getStorable() -> StorableMovie {
        return StorableMovie.init(id: id,
                                  originalTitle: originalTitle,
                                  posterPath: posterPath,
                                  voteAverage: voteAverage,
                                  overview: overview,
                                  favourite: favourite)
    }
}
