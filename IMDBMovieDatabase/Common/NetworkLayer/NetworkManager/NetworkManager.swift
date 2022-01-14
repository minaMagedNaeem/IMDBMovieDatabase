//
//  File.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

protocol NetworkManager {
    func getMovies(page: Int, completion: @escaping ((NetworkError?, [Movie]?) -> Void))
}
