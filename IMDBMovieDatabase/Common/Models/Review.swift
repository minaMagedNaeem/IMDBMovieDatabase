//
//  Review.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/16/22.
//

import Foundation

class Review: Codable {
    let author: String
    let authorDetails: AuthorDetails?
    let content: String
    
    var storableReview: StorableReview {
        return StorableReview(author: author, authorDetails: authorDetails?.storableAuthorDetails, content: content)
    }

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
    }

    init(author: String, authorDetails: AuthorDetails?, content: String) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
    }
}
