//
//  StorableAuthorDetails.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import RealmSwift

class StorableAuthorDetails: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var avatarPath: String?
    @Persisted var rating: Int?
    
    var domainAuthorDetails: AuthorDetails {
        return AuthorDetails(name: name, avatarPath: avatarPath, rating: rating)
    }
    
    init(name: String, avatarPath: String?, rating: Int?) {
        super.init()
        self.name = name
        self.avatarPath = avatarPath
        self.rating = rating
    }
    
    required override init() {
        super.init()
    }
}
