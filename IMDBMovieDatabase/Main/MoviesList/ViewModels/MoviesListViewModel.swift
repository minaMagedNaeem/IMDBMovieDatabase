//
//  MoviesListViewModel.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class MoviesListViewModel {
    
    // MARK: - Global Variables
    var onListRetrieval: (() -> Void)?
    
    var shownMoviesList: [Movie] = []  {
        didSet {
            onListRetrieval?()
        }
    }
    
    var moviesCount: Int {
        return shownMoviesList.count
    }
    
    var nextPageNumber : Int? = 1
    
    var networkManager: MoviesNetworkManager?
    
    var moviesRepo: MoviesRepo?
    
    var isShowingFavourites: Bool {
        return currentDisplayedMoviesFilter == .favourites
    }
    
    var canFetchMorePages: Bool {
        // 500 is the max page number the api is allowed to take
        if let page = self.nextPageNumber,
           (page >= 1 && page <= 500),
           self.currentDisplayedMoviesFilter == .all,
           self.currentDataRetrievalMethod == .online {
            return true
        }
        return false
    }
    
    // MARK: - Private Variables
    private var allMoviesList: [Movie] = []
    
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
    
    private var currentDataRetrievalMethod: DataRetrievalMethod = .online
    
    init(networkManager: MoviesNetworkManager, repo: MoviesRepo) {
        self.networkManager = networkManager
        
        self.moviesRepo = repo
    }
    
    // MARK: - Public Methods
    func getMoviesLists(firstRun: Bool = false, successCompletion: (() -> Void)? = nil, failureCompletion: (() -> Void)? = nil) {
        if firstRun {
            self.reset()
        }
        
        guard self.canFetchMorePages else { return }
        
        if Connectivity.isConnectedToInternet() {
            self.networkManager?.getMovies(page: self.nextPageNumber!, completion: {[weak self] (error, movies) in
                
                if error != nil {
                    failureCompletion?()
                    return
                }
                
                self?.addMovies(movies: movies ?? [])
                successCompletion?()
            })
        } else {
            self.nextPageNumber = nil
            self.currentDataRetrievalMethod = .offline
            
            let movies = moviesRepo?.getMovies() ?? []
            
            self.allMoviesList = movies
            self.shownMoviesList = allMoviesList
            successCompletion?()
        }
    }
    
    func toggleFavourites() {
        self.currentDisplayedMoviesFilter = self.currentDisplayedMoviesFilter == .all ? .favourites : .all
    }
    
    func toggleMovieFavourite(for movieId: Int, completion: @escaping ((Int) -> Void)) {
        for (index, movie) in self.shownMoviesList.enumerated() where movie.id == movieId {
            movie.favourite = !movie.favourite
            self.moviesRepo?.updateMovie(movie: movie)
            completion(index)
        }
    }
    
    func movie(for index: Int) -> Movie {
        return self.shownMoviesList[index]
    }
    
    // MARK: - Private Methods
    private func addMovies(movies: [Movie]) {
        self.nextPageNumber = movies.isEmpty ? nil : (self.nextPageNumber ?? 1) + 1

        self.allMoviesList.append(contentsOf: movies)
        
        self.shownMoviesList = allMoviesList
        
        self.moviesRepo?.storeMovies(movies: movies)
    }
    
    private func reset() {
        self.allMoviesList = []
        self.shownMoviesList = []
        self.currentDisplayedMoviesFilter = .all
        self.nextPageNumber = 1
        self.currentDataRetrievalMethod = .online
    }
    
    // MARK: - Enums
    enum MoviesType {
        case all
        case favourites
    }
    
    enum DataRetrievalMethod {
        case online
        case offline
    }
}
