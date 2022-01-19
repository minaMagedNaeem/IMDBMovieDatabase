//
//  MoviesTestsNetworkManager.swift
//  IMDBMovieDatabaseTests
//
//  Created by Mina Maged on 1/18/22.
//

import Foundation
@testable import IMDBMovieDatabase

class MoviesTestsNetworkManager: MoviesNetworkManager {
    func getMovies(page: Int, completion: @escaping ((NetworkError?, [Movie]?) -> Void)) {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MoviesList", ofType: "json") else {
            fatalError("MoviesList.json not found")
        }
        
        let pathUrl = URL(fileURLWithPath: pathString)
        
        //do {
            let data = try! Data(contentsOf: pathUrl)
            let decoder = JSONDecoder()
            let movies = try! decoder.decode([Movie].self, from: data)
            completion(nil, movies)
        //} catch {
            //print(error.localizedDescription)
        //}
    }
}
