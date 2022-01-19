//
//  MainCoordinator.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var window: UIWindow?
    var rootViewController: UINavigationController
    
    required init(window: UIWindow?, rootViewController: UINavigationController) {
        self.window = window
        self.rootViewController = rootViewController
    }
    
    func start() {
        rootViewController.navigationBar.prefersLargeTitles = true
        
        rootViewController.viewControllers = [MoviesListFactory.getViewController(coordinator: self)]
        
        window?.rootViewController = rootViewController
    }
    
    func showDetails(of movie: Movie) {
        rootViewController.pushViewController(MovieDetailsFactory.getViewController(coordinator: self, movie: movie), animated: true)
    }
    
    
}
