//
//  StorableReview.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import RealmSwift

class StorableReview: Object {
    @Persisted(primaryKey: true) var author: String
    @Persisted var content: String
    @Persisted var authorDetails: StorableAuthorDetails?
    
    var domainReview: Review {
        return Review(author: author, authorDetails: self.authorDetails?.domainAuthorDetails, content: self.content)
    }
    
    init(author: String, authorDetails: StorableAuthorDetails?, content: String) {
        super.init()
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
    }
    
    required override init() {
        super.init()
    }
}
