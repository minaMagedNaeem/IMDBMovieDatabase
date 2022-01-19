//
//  MovieDetailsFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MovieDetailsFactory {
    class func getViewController(coordinator: Coordinator, movie: Movie) -> MovieDetailsViewController {
        return MovieDetailsViewController(coordinator: coordinator, viewModel: MovieDetailsViewModel(movie: movie,
                                                                           networkManager: ReviewsNetworkManagerFactory.getNetworkManager(),
                                                                           reviewsRepo: ReviewsRepoFactory.getRepo(),
                                                                           moviesRepo: MoviesRepoFactory.getRepo()))
    }
}
