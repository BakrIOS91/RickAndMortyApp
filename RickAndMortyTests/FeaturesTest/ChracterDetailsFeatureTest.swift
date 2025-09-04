//
//  ChracterDetailsFeatureTest.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//

import Testing
import ComposableArchitecture
@testable import RickAndMorty

struct ChracterDetailsFeatureTests {
    
    // MARK: - Initial Load
    
    @Test("Given a character ID, When fetching character details, Then character loads successfully")
    func testFetchCharacterDetailsSuccess() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = .testValue
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.success) {
            $0.characterDetails = CharacterListItem.mockCharacterListItem
            $0.viewState = .loaded
        }
    }
    
    @Test("Given a character ID, When fetching character details fails with no network, Then state updates to no network error")
    func testFetchCharacterDetailsFailNoNetwork() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = .failNoNetworkValue
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.failure) {
            $0.characterDetails = nil
            $0.viewState = .noNetwork
        }
    }
    
    @Test("Given a character ID, When fetching character details fails with decode error, Then state updates to unexpected error")
    func testFetchCharacterDetailsFailDecode() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = .failDecodeValue
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.failure) {
            $0.characterDetails = nil
            $0.viewState = .unExpectedError
        }
    }
    
    @Test("Given a character ID, When fetching character details returns nil, Then state updates to no data")
    func testFetchCharacterDetailsReturnsNil() async {
        let characterId = 999
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = CharactersClient(
                getCharacters: { _, _ in .success(.mockCharacterList) },
                getChracterDetails: { _ in .success(nil) }
            )
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.success) {
            $0.characterDetails = nil
            $0.viewState = .noData
        }
    }
    

    // MARK: - Error Handling
    
    @Test("Given a character details feature, When server error occurs, Then state updates to server error")
    func testServerError() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = CharactersClient(
                getCharacters: { _, _ in .success(.mockCharacterList) },
                getChracterDetails: { _ in .failure(.httpError(statusCode: .clientError)) }
            )
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.failure) {
            $0.characterDetails = nil
            $0.viewState = .serverError
        }
    }
    
    @Test("Given a character details feature, When unexpected error occurs, Then state updates to unexpected error")
    func testUnexpectedError() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = CharactersClient(
                getCharacters: { _, _ in .success(.mockCharacterList) },
                getChracterDetails: { _ in .failure(.invalidURL) }
            )
        }
        
        // When
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        // Then
        await store.receive(\.characterDetailsResponse.failure) {
            $0.characterDetails = nil
            $0.viewState = .unExpectedError
        }
    }
    
    // MARK: - Multiple Fetch Attempts
    
    @Test("Given a character details feature, When fetching multiple times, Then each fetch is handled independently")
    func testMultipleFetchAttempts() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = .testValue
        }
        
        // First fetch
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        await store.receive(\.characterDetailsResponse.success) {
            $0.characterDetails = CharacterListItem.mockCharacterListItem
            $0.viewState = .loaded
        }
        
        // Second fetch
        await store.send(.fetchCharacter) {
            $0.viewState = .overlayLoading(.white)
        }
        
        await store.receive(\.characterDetailsResponse.success) {
            $0.characterDetails = CharacterListItem.mockCharacterListItem
            $0.viewState = .loaded
        }
    }
    
    // MARK: - Navigation Actions
    
    @Test("Given a character details feature, When back button is pressed, Then delegate dismiss action is sent")
    func testDidPressOnBackButton() async {
        let characterId = 781
        let store = await TestStore(
            initialState: ChracterDetailsFeature.State(characterId: characterId)
        ) {
            ChracterDetailsFeature()
        } withDependencies: {
            $0.charactersClient = .testValue
        }
        
        // When
        await store.send(.didPressOnBackButton)
        
        // Then
        await store.receive(\.delegate)
    }
}
