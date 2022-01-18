//
//  MoviesListFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation

class MoviesListFactory {
    class func getViewController(coordinator: Coordinator, isTesting: Bool = false) -> MoviesListViewController {
        return MoviesListViewController(coordinator: coordinator,
                                        viewModel: MoviesListViewModel(networkManager: MoviesNetworkManagerFactory.getNetworkManager(isTesting: isTesting),
                                                                       repo: MoviesRepoFactory.getRepo(isTesting: isTesting)))
    }
}
