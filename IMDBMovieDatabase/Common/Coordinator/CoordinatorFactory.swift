//
//  CoordinatorFactory.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/17/22.
//

import Foundation
import UIKit

class CoordinatorFactory {
    class func getCoordinator(window: UIWindow?, rootViewController: UINavigationController) -> Coordinator {
        return MainCoordinator(window: window, rootViewController: rootViewController)
    }
}
