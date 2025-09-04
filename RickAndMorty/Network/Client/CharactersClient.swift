//
//  CharactersClient.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import BMSwiftNetworking

struct CharactersClient {
    var getCharacters: (_ pageIndex: Int, _ searchText: String) async -> Result<CharacterList?, APIError>
    var getChracterDetails: (_ chracterId: Int) async -> Result<CharacterListItem?, APIError>

}

extension DependencyValues {
    var charactersClient: CharactersClient {
        get { self[CharactersClient.self] }
        set { self[CharactersClient.self] = newValue }
    }
}

extension CharactersClient: TestDependencyKey {
    static var previewValue: CharactersClient {
        .init { _, _ in
            return .success(.mockCharacterList)
        } getChracterDetails: { chracterId in
            return .success(.mockCharacterListItem)
        }
    }
    
    static var testValue: CharactersClient {
        .init { _, _ in
            return .success(.mockCharacterList)
        } getChracterDetails: { chracterId in
            return .success(.mockCharacterListItem)
        }

    }
    
    static var failNoNetworkValue: CharactersClient {
        .init { _, _ in
            return .failure(.noNetwork)
        } getChracterDetails: { chracterId in
            return .failure(.noNetwork)
        }
    }
    
    static var failDecodeValue: CharactersClient {
        .init { _, _ in
            return .failure(.dataConversionFailed)
        } getChracterDetails: { chracterId in
            return .failure(.dataConversionFailed)
        }
    }
}

extension CharactersClient: DependencyKey {
    static var liveValue: CharactersClient {
        .init { pageIndex, searchText in
            return await ChractersRequest.GetCharacters(pageIndex: pageIndex, searchText: searchText).performResult()
        } getChracterDetails: { chracterId in
            return await ChractersRequest.GetCharacterDetails(characterId: chracterId).performResult()
        }
    }
}
