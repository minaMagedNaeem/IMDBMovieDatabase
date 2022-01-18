//
//  MovieDetailsViewModel.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/16/22.
//

import Foundation

class MovieDetailsViewModel {
    
    // MARK: - Global Variables
    var onListRetrieval: (() -> Void)?
    
    private var allReviews: [Review] = []
    
    var shownReviews: [Review] = []  {
        didSet {
            onListRetrieval?()
        }
    }
    
    var reviewsCount: Int {
        return shownReviews.count
    }
    
    var nextPageNumber : Int? = 1
    
    var networkManager: ReviewsNetworkManager?
    
    var reviewsRepo: ReviewsRepo?
    
    var moviesRepo: MoviesRepo?
    
    var movie: Movie
    
    var canFetchMorePages: Bool {
        // 1000 is the max page number the api is allowed to take
        if let page = self.nextPageNumber,
           (page >= 1 && page <= 1000) {
            return true
        }
        return false
    }
    
    init(movie: Movie, networkManager: ReviewsNetworkManager, reviewsRepo: ReviewsRepo, moviesRepo: MoviesRepo) {
        self.movie = movie
        
        self.networkManager = networkManager
        self.reviewsRepo = reviewsRepo
        self.moviesRepo = moviesRepo
    }
    
    // MARK: - Global Methods
    func getReviewsLists() {
        
        guard self.canFetchMorePages else { return }
        
        if Connectivity.isConnectedToInternet() {
            self.networkManager?.getReviews(movieId: movie.id, page: self.nextPageNumber!, completion: {[weak self] (error, reviews) in
                if error != nil {
                    return
                }
                self?.addReviews(reviews: reviews ?? [])
            })
        } else {
            self.nextPageNumber = nil
            
            let reviews = reviewsRepo?.getReviews() ?? []
            
            self.allReviews = reviews
            self.shownReviews = reviews
        }
    }
    
    func review(for index: Int) -> Review {
        return self.shownReviews[index]
    }
    
    func toggleMovieFavourite() {
        movie.favourite = !movie.favourite
        self.moviesRepo?.updateMovie(movie: movie)
    }
    
    func rateMovie(rate: Int, completion: @escaping ((_ success: Bool) -> Void)) {
        self.networkManager?.rateMovie(movieId: movie.id, rate: rate, completion: completion)
    }
    
    // MARK: - Private Variables
    private func addReviews(reviews: [Review]) {
        self.nextPageNumber = reviews.isEmpty ? nil : (self.nextPageNumber ?? 1) + 1

        self.allReviews.append(contentsOf: reviews)
        
        self.shownReviews = allReviews
        
        self.reviewsRepo?.storeReviews(reviews: reviews)
    }
}
