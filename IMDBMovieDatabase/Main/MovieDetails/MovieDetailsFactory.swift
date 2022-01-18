//
//  MovieDetailsFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MovieDetailsFactory {
    class func getViewController(coordinator: Coordinator, movie: Movie, isTesting: Bool = false) -> MovieDetailsViewController {
        return MovieDetailsViewController(coordinator: coordinator, viewModel: MovieDetailsViewModel(movie: movie,
                                                                           networkManager: ReviewsNetworkManagerFactory.getNetworkManager(isTesting: isTesting),
                                                                           reviewsRepo: ReviewsRepoFactory.getRepo(isTesting: isTesting),
                                                                           moviesRepo: MoviesRepoFactory.getRepo(isTesting: isTesting)))
    }
}
