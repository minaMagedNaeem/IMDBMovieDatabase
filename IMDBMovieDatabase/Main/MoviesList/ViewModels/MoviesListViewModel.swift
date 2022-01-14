//
//  MoviesListViewModel.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class MoviesListViewModel {
    
    var onListRetrieval: (() -> Void)?
    
    var moviesList: [Movie] = [] {
        didSet {
            onListRetrieval?()
        }
    }
    
    var nextPageNumber : Int? = 1
    
    var networkManager: NetworkManager?
    
    init (onListRetrieval: @escaping (() -> Void)) {
        self.onListRetrieval = onListRetrieval
        
        self.networkManager = MoviesNetworkManager()
    }
    
    func getMoviesLists(successCompletion: @escaping ([Int]) -> Void) {
        
        guard self.canFetchMorePages else { return }
        
        self.networkManager?.getMovies(page: self.nextPageNumber!, completion: {[weak self] (error, movies) in
            self?.addMovies(movies: movies ?? [], successCompletion: successCompletion)
        })
    }
    
    var canFetchMorePages: Bool {
        // 500 is the max page number the api is allowed to take
        if let page = self.nextPageNumber, (page >= 1 && page <= 500) {
            return true
        }
        return false
    }
    
    private func addMovies(movies: [Movie], successCompletion: @escaping ([Int]) -> Void) {
        self.nextPageNumber = movies.isEmpty ? nil : (self.nextPageNumber ?? 1) + 1
        
        var updatedMoviesIndexes: [Int] = []
        
        var lastIndex = self.moviesList.count
        
        for movie in movies {
            self.moviesList.append(movie)
            updatedMoviesIndexes.append(lastIndex)
            lastIndex = lastIndex + 1
        }
        
        successCompletion(updatedMoviesIndexes)
    }
    
    func changeFavouriteStatus(for movieId: Int, isFavourite: Bool) {
        
    }
    
}
