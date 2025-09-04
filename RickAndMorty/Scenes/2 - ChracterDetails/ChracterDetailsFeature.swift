//
//  ChracterDetailsFeature.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//  Copyright © 2025 Link Development. All rights reserved.
//

import ComposableArchitecture
import Foundation
import BMSwiftNetworking

@Reducer
struct ChracterDetailsFeature {
    
    //MARK: - Typealias
    typealias FeatureEffect = Effect<ChracterDetailsFeature.Action>
    typealias FeatureState = ChracterDetailsFeature.State
    
    @Dependency(\.charactersClient) var charactersClient
    
    @ObservableState
    struct State: Equatable {
        var viewState: ViewState = .loaded
        var characterId: Int
        var characterDetails: CharacterListItem?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchCharacter
        case characterDetailsResponse(Result<CharacterListItem?, APIError>)
        case didPressOnBackButton
        case delegate(Delegate)
        
        enum Delegate {
            case dismiss
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchCharacter:
                return handleFetchCharacter(state: &state)
            case let .characterDetailsResponse(result):
                return handleCharacterDetailsResponse(state: &state, result: result)
            case .didPressOnBackButton:
                return .send(.delegate(.dismiss))
            case .binding, .delegate:
                return .none
            }
        }
    }
    
}

extension ChracterDetailsFeature {
    
    func handleFetchCharacter(
        state: inout FeatureState
    ) -> FeatureEffect {
        state.viewState = .overlayLoading(.white)
        
        return .run { [characterId = state.characterId] send in
            await send(
                .characterDetailsResponse(
                    charactersClient.getChracterDetails(characterId)
                )
            )
        }
    }
    
    func handleCharacterDetailsResponse(
        state: inout FeatureState,
        result: Result<CharacterListItem?, APIError>
    ) -> FeatureEffect {
        switch result {
        case let .success(character):
            if let character = character {
                state.characterDetails = character
                state.viewState = .loaded
            } else {
                state.viewState = .noData
            }
        case let .failure(error):
            state.viewState = ViewState.failHandler(error)
        }
        return .none
    }
    
}
