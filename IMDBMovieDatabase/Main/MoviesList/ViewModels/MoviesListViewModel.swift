//
//  MoviesListViewModel.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class MoviesListViewModel {
    
    var onListRetrieval: (() -> Void)?
    
    private var allMoviesList: [Movie] = []
    
    var shownMoviesList: [Movie] = []  {
        didSet {
            onListRetrieval?()
        }
    }
    
    var nextPageNumber : Int? = 1
    
    var networkManager: NetworkManager?
    
    private var currentDisplayedMoviesFilter: MoviesType = .all {
        didSet {
            switch currentDisplayedMoviesFilter {
            case .all:
                self.shownMoviesList = allMoviesList
            case .favourites:
                self.shownMoviesList = allMoviesList.filter({ $0.favourite })
            }
        }
    }
    
    var isShowingFavourites: Bool {
        return currentDisplayedMoviesFilter == .favourites
    }
    
    init (onListRetrieval: @escaping (() -> Void)) {
        self.onListRetrieval = onListRetrieval
        
        self.networkManager = MoviesNetworkManager()
    }
    
    func getMoviesLists(successCompletion: (() -> Void)? = nil, failureCompletion: (() -> Void)? = nil) {
        
        guard self.canFetchMorePages else { return }
        
        self.networkManager?.getMovies(page: self.nextPageNumber!, completion: {[weak self] (error, movies) in
            
            if error != nil {
                failureCompletion?()
                return
            }
            
            self?.addMovies(movies: movies ?? [])
            successCompletion?()
        })
    }
    
    var canFetchMorePages: Bool {
        // 500 is the max page number the api is allowed to take
        if let page = self.nextPageNumber, (page >= 1 && page <= 500), self.currentDisplayedMoviesFilter == .all {
            return true
        }
        return false
    }
    
    private func addMovies(movies: [Movie]) {
        self.nextPageNumber = movies.isEmpty ? nil : (self.nextPageNumber ?? 1) + 1

        self.allMoviesList.append(contentsOf: movies)
        
        self.shownMoviesList = allMoviesList
    }
    
    func toggleFavourites() {
        self.currentDisplayedMoviesFilter = self.currentDisplayedMoviesFilter == .all ? .favourites : .all
    }
    
    func toggleMovieFavourite(for movieId: Int, completion: @escaping ((Int) -> Void)) {
        for (index, movie) in self.shownMoviesList.enumerated() where movie.id == movieId {
            movie.favourite = !movie.favourite
            completion(index)
        }
    }
    
    enum MoviesType {
        case all
        case favourites
    }
}
