//
//  File.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class TMDB {
    static func getAPIKey() -> String {
        
        guard let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else {
            fatalError("Couldn't find file 'APIKeys.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'APIKeys.plist'.")
        }
        return value
    }
}
