//
//  Coordinator.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var window: UIWindow? { get set }
    var rootViewController: UINavigationController { get set }
    
    init(window: UIWindow?, rootViewController: UINavigationController)
    
    func start()
    
    func showDetails(of movie: Movie)
}
