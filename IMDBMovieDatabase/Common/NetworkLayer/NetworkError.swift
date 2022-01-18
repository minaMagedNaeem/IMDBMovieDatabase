//
//  NetworkError.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

enum NetworkError {
    case noInternet
    case networkError(errorCode: Int)
    case decodeError
}
