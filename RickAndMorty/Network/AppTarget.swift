//
//  AppTarget.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import BMSwiftNetworking

struct AppTarget: Target {
    var appEnvironment: AppEnvironment = .production
    
    var kAppHost: String {
        switch appEnvironment {
        default:
            return "rickandmortyapi.com"
        }
    }
    
    var kMainAPIPath: String? {
        return "api"
    }
    
    var kAppScheme: String {
        switch appEnvironment {
            default: "https"
        }
    }
}
