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
    case getReviews(movieId: Int, page: Int)
    case rateMovie(movieId: Int, rate: Int)
    case registerGuestSession
    
    public var baseURL: URL {
        return URL.init(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "/discover/movie"
        case .getReviews(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .rateMovie(let movieId, _):
            return "/movie/\(movieId)/rating"
        case .registerGuestSession:
            return "/authentication/guest_session/new"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovies, .getReviews, .registerGuestSession:
            return .get
        case .rateMovie:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getMovies(let page):
            return .requestParameters(parameters: ["page": page,
                                                   "sort_by":"popularity.desc"],
                                      encoding: URLEncoding.default)
        case .getReviews(_, let page):
            return .requestParameters(parameters: ["page": page],
                                      encoding: URLEncoding.default)
        case .rateMovie(_, let rate):
            return .requestParameters(parameters: ["value": rate],
                                      encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

let imdbMoviesProvider = MoyaProvider<ImdbAPI>.init(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: [.formatRequestAscURL, .successResponseBody, .errorResponseBody])), AuthPlugin()])

struct AuthPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        var request = request
        var authQuery: [URLQueryItem] = []
        
        authQuery = [URLQueryItem(name: "api_key", value: TMDBKeysManager.getAPIKey())]
        
        if let target = target as? ImdbAPI {
            switch target {
            case .rateMovie:
                authQuery.append(URLQueryItem(name: "guest_session_id", value: TMDBKeysManager.getGuestAPIKey()))
            default:
                break
            }
        }
        
        var urlComp = URLComponents(string: request.url!.absoluteString)
        if urlComp?.queryItems != nil {
            urlComp?.queryItems?.append(contentsOf: authQuery)
        } else {
            urlComp?.queryItems = authQuery
        }
        request.url = urlComp?.url
        return request
    }
}
