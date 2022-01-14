//
//  ImdbAPI.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation
import Moya

enum ImdbAPI : TargetType {
    
    case getMovies(page: Int)
    
    public var baseURL: URL {
        return URL.init(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "/discover/movie"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getMovies(let page):
            return .requestParameters(parameters: ["api_key": TMDB.getAPIKey(),
                                                   "page": page,
                                                   "sort_by":"popularity.desc"],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

let imdbMoviesProvider = MoyaProvider<ImdbAPI>.init(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: .verbose))])

