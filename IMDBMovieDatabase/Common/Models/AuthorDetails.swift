//
//  AuthorDetails.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class AuthorDetails: Codable {
    let name: String
    let avatarPath: String?
    let rating: Int?
    
    var storableAuthorDetails: StorableAuthorDetails {
        return StorableAuthorDetails(name: name, avatarPath: avatarPath, rating: rating)
    }

    enum CodingKeys: String, CodingKey {
        case name = "username"
        case avatarPath = "avatar_path"
        case rating
    }

    init(name: String, avatarPath: String?, rating: Int?) {
        self.name = name
        self.avatarPath = avatarPath
        self.rating = rating
    }
}
