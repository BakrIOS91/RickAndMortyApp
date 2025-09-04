//
//  CharacterListFeatureTest.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//

import Testing
import ComposableArchitecture
@testable import RickAndMorty

struct CharacterListFeatureTests {
    
    // MARK: - Initial Load
    
    @Test("Given a fresh state, When fetching the first page, Then characters load successfully")
    func testInitialLoadSuccess() async {
        let store = await TestStore(initialState: CharacterListFeature.State()) {
            CharacterListFeature()
        } withDependencies: {
            $0.charactersClient = .testValue
        }
        
        // When
        await store.send(.fetchCharacterList(at: .first)) {
            $0.viewState = .overlayLoading(.white)
            $0.pageIndex = 1
            $0.shouldPaginate = false
        }
        
        // Then
        await store.receive(\.characterListResponse.success) {
            $0.characterListItems = CharacterListItem.mockCharacterListItemArray
            $0.viewState = .loaded
            $0.shouldPaginate = false
        }
    }
    
    // MARK: - Pagination
    
    @Test("Given characters exist, When fetching next page, Then new characters append to list")
    func testPaginationNextPage() async {
        let store = await TestStore(
            initialState: CharacterListFeature.State(
                characterListItems: CharacterListItem.mockCharacterListItemArray,
                pageIndex: 1
            )){
                CharacterListFeature()
            } withDependencies:  {
                $0.charactersClient = .testValue
            }
        
        // When
        await store.send(.fetchCharacterList(at: .next)) {
            $0.pageIndex = 2
        }
        
        // Then
        await store.receive(\.characterListResponse.success) {
            $0.characterListItems.append(contentsOf: CharacterListItem.mockCharacterListItemArray)
            $0.viewState = .loaded
            $0.shouldPaginate = false
        }
    }
    
    @Test("Given search text changes, When binding updates, Then a new fetch is triggered after debounce")
    func testSearchTextBindingTriggersFetch() async {
        let store = await TestStore(
            initialState: CharacterListFeature.State(searchText: "", oldSearchText: "")
        ) {
            CharacterListFeature()
        } withDependencies: {
            $0.charactersClient = .previewValue
        }
    
        // Then
        await store.send(\.binding.searchText, "Rick") {
            $0.searchText = "Rick"
            $0.oldSearchText = "Rick"
        }
        
        // Then (debounced fetch)
        await store.receive(\.fetchCharacterList){
            $0.viewState = .overlayLoading(.white)
            $0.pageIndex = 1
            $0.shouldPaginate = false
        }
        
        // Then
        await store.receive(\.characterListResponse.success) {
            $0.characterListItems = CharacterListItem.mockCharacterListItemArray
            $0.viewState = .loaded
            $0.shouldPaginate = false
        }
    }

    // MARK: - Failure
    
    @Test("Given a failing client, When fetching characters, Then state updates to failure")
    func testFailNoNetwork() async {
        let store = await TestStore(initialState: CharacterListFeature.State()) {
            CharacterListFeature()
        } withDependencies: {
            $0.charactersClient = .failNoNetworkValue
        }
        
        // When
        await store.send(.fetchCharacterList(at: .first)) {
            $0.viewState = .overlayLoading(.white)
            $0.pageIndex = 1
            $0.shouldPaginate = false
        }
        
        // Then
        await store.receive(\.characterListResponse.failure) {
            $0.characterListItems = []
            $0.viewState = .noNetwork
            $0.shouldPaginate = false
        }
    }
    
    @Test("Given a failing client, When fetching characters, Then state updates to failure")
    func testFailDecoding() async {
        let store = await TestStore(initialState: CharacterListFeature.State()) {
            CharacterListFeature()
        } withDependencies: {
            $0.charactersClient = .failDecodeValue
        }
        
        // When
        await store.send(.fetchCharacterList(at: .first)) {
            $0.viewState = .overlayLoading(.white)
            $0.pageIndex = 1
            $0.shouldPaginate = false
        }
        
        // Then
        await store.receive(\.characterListResponse.failure) {
            $0.characterListItems = []
            $0.viewState = .unExpectedError
            $0.shouldPaginate = false
        }
    }

    // MARK: - Character Selection
    
    @Test("Given a character exists, When selecting it, Then no effect is produced")
    func testSelectCharacter() async {
        let character = CharacterListItem.mockCharacterListItem
        let store = await TestStore(initialState: CharacterListFeature.State()) {
            CharacterListFeature()
        } withDependencies: {
            $0.charactersClient = .testValue
        }
        
        // When & Then (currently no effect)
        await store.send(.didSelectCharacter(character))
    }
}
