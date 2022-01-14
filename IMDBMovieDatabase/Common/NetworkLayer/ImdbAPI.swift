//
//  ImdbAPI.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation
import Moya

enum ImdbAPI : TargetType {
    
    case getMovies
    
    public var baseURL: URL {
        return URL.init(string: "https://raw.githubusercontent.com")!
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "/EsraaAbdelmotteleb/DuetAPI/gh-pages/project.json"
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
        case .getMovies:
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

final class ErrorHandlerPlugin : PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
        if !(Connectivity.isConnectedToInternet()) {
            return
        }
        
        UIApplication.topViewController()?.displayAlert(title: "Error", message: "Something wrong happened")
    }
}

let imdbMoviesProvider = MoyaProvider<ImdbAPI>.init(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration.init(logOptions: .verbose)), ErrorHandlerPlugin()])

