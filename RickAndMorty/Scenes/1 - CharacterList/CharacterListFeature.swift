//
//  CharacterListFeature.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//  Copyright © 2025 Link Development. All rights reserved.
//

import ComposableArchitecture
import Foundation
import BMSwiftNetworking

@Reducer
struct CharacterListFeature {
    
    //MARK: - Typealias
    typealias FeatureEffect = Effect<CharacterListFeature.Action>
    typealias FeatureState = CharacterListFeature.State
    
    @Dependency(\.charactersClient) var charactersClient
    
    @ObservableState
    struct State {
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            return .none
        }
    }
    
}
