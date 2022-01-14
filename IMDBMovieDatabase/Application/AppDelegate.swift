//
//  AppDelegate.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navController = UINavigationController(rootViewController: MoviesListViewController.init(nibName: "MoviesListViewController", bundle: nil))
        
        navController.navigationBar.prefersLargeTitles = true
        
        window?.rootViewController = navController
        
        return true
    }
}

