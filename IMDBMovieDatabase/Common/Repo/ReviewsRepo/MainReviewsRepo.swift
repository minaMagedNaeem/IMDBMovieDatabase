//
//  MainReviewsRepo.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import RealmSwift

class MainReviewsRepo: ReviewsRepo {
    
    let realm = try? Realm()
    
    func getReviews() -> [Review] {
        if let results = realm?.objects(StorableReview.self) {
            return Array(results.map({ $0.domainReview }))
        }
        return []
    }
    
    func storeReviews(reviews: [Review]) {
        let storableReviews = reviews.map({$0.storableReview})
        try? realm?.write {
            realm?.add(storableReviews, update: .modified)
        }
    }
}
