//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 02/09/2025.
//

import SwiftUI
import BMSwiftNetworking
import ComposableArchitecture

@main
struct RickAndMortyApp: App {
    
    init() {
        Helpers.setupNavigationBarAppearance()
        NetworkMonitor.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            CharacterListView(
                store: .init(
                    initialState: CharacterListFeature.State(),
                    reducer: {
                        CharacterListFeature()
                    }
                )
            )
        }
    }
}
