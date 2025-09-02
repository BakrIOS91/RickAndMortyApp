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
    var getCharacters: (_ pageIndex: Int) async -> Result<CharacterList?, APIError>
}

extension DependencyValues {
    var charactersClient: CharactersClient {
        get { self[CharactersClient.self] }
        set { self[CharactersClient.self] = newValue }
    }
}

extension CharactersClient: TestDependencyKey {
    static var previewValue: CharactersClient {
        .init { _ in
            return .success(.mockCharacterList)
        }
    }
    
    static var testValue: CharactersClient {
        .init { _ in
            return .success(.mockCharacterList)
        }
    }
}

extension CharactersClient: DependencyKey {
    static var liveValue: CharactersClient {
        .init { pageIndex in
            return await ChractersRequest.GetCharacters(pageIndex: pageIndex).performResult()
        }
    }
}
