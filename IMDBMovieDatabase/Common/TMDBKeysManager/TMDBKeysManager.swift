//
//  TMDBKeysManager.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import Foundation

class TMDBKeysManager {
    static func getAPIKey() -> String {
        
        guard let filePath = Bundle.main.path(forResource: "TMDBKeys", ofType: "plist") else {
            fatalError("Couldn't find file 'TMDBKeys.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'TMDBKeys.plist'.")
        }
        return value
    }
    
    private static var guestAPIKey: String?
    
    static func setGuestAPIKey(key: String) {
        guestAPIKey = key
    }
    
    static func getGuestAPIKey() -> String? {
        return guestAPIKey
    }
    
}
