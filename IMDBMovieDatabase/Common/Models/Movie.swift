//
//  Movie.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation
import RealmSwift

class CoffeeDrink: Object {
    @Persisted var name: String = ""
    @Persisted var image: String?
    @Persisted var rating: String = ""
    @Persisted var favourite: Bool = false
}
