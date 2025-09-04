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
    struct State: Equatable {
        var viewState: ViewState = .loaded
        var characterListItems: [CharacterListItem] = []
        var pageIndex: Int = 1
        var shouldPaginate: Bool = false
        var searchText: String = ""
        var oldSearchText: String = ""
        
        @Presents var characterDetailsState: ChracterDetailsFeature.State?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchCharacterList(at: Page)
        case characterListResponse(Result<CharacterList?, APIError>)
        case didSelectCharacter(CharacterListItem)
        case characterDetailsAction(PresentationAction<ChracterDetailsFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .fetchCharacterList(page):
                return handleFetchCharacterList(state: &state, page: page)
            case let .characterListResponse(result):
                return handleFetchCharacterListResponse(state: &state, result: result)
            case let .didSelectCharacter(character):
                return handleDidSelectCharacter(state: &state, character: character)
            case .binding(\.searchText):
                return handleSearchTextBinding(state: &state)
            case .characterDetailsAction(.presented(.delegate(.dismiss))):
                return .send(.characterDetailsAction(.dismiss))
            case .binding, .characterDetailsAction:
                return .none
            }
        }
        .ifLet(\.$characterDetailsState, action: \.characterDetailsAction){
            ChracterDetailsFeature()
        }
    }
    
}

extension CharacterListFeature {
    
    func handleFetchCharacterList(
        state: inout FeatureState,
        page: Page
    ) -> FeatureEffect {
        
        switch page {
        case .first:
            state.shouldPaginate = false
            state.viewState = .overlayLoading(.white)
            state.pageIndex = 1
        case .next:
            state.pageIndex += 1
        }
        
        return .run { [pageIndex = state.pageIndex, searchText = state.searchText] send in
            await send(
                .characterListResponse(
                    charactersClient.getCharacters(pageIndex, searchText)
                )
            )
        }
    }
    
    func handleFetchCharacterListResponse(
        state: inout FeatureState,
        result: Result<CharacterList?, APIError>
    ) -> FeatureEffect {
        switch result {
        case let .success(response):
            guard let characters = response?.results, !characters.isEmpty else {
                if state.pageIndex == 1 {
                    state.characterListItems.removeAll()
                    state.viewState = state.searchText.isEmpty ? .noData : .searchError
                } else {
                    state.shouldPaginate = false
                    state.viewState = .loaded
                }
                return .none
            }
            
            if state.pageIndex == 1 {
                state.characterListItems.removeAll()
            }
            state.characterListItems.append(contentsOf: characters)
            state.shouldPaginate = state.pageIndex < response?.info.pages ?? 1
            state.viewState = .loaded
            
        case let .failure(error):
            state.viewState = ViewState.failHandler(error)
        }
        return .none
    }
    
    func handleDidSelectCharacter(
        state: inout FeatureState,
        character: CharacterListItem
    ) -> FeatureEffect {
        state.characterDetailsState = .init(characterId: character.id)
        return .none
    }
    
    func handleSearchTextBinding(
        state: inout FeatureState
    ) -> FeatureEffect {
        if state.searchText == state.oldSearchText {
            return .none
        }
        state.oldSearchText = state.searchText
        return .send(.fetchCharacterList(at: .first))
            .debounce(
                id: "Search Text Debounce",
                for: .seconds(1),
                scheduler: RunLoop.main
            )
    }
    
}
