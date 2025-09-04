//
//  ChractersRequest.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import Foundation
import BMSwiftNetworking

struct ChractersRequest {
    
    struct GetCharacters: ModelTargetType {
        typealias Response = CharacterList?
        
        var baseURL: String { return AppTarget().kBaseURL }
        
        var requestPath: String { return "/character" }
        
        var requestMethod: HTTPMethod { return .GET }
        
        var mockResponse:  CharacterList? { return .mockCharacterList }
        
        var pageIndex: Int
        var searchText: String
        
        var requestTask: RequestTask {
            return .parameters([
                "page": pageIndex,
                "name": searchText
            ])
        }
        
        init(pageIndex: Int, searchText: String) {
            self.pageIndex = pageIndex
            self.searchText = searchText
        }
    }
    
    
    struct GetCharacterDetails: ModelTargetType {
        typealias Response = CharacterListItem?
        
        var baseURL: String { return AppTarget().kBaseURL }
        
        var requestPath: String { return "/character/\(characterId)" }
        
        var requestMethod: HTTPMethod { return .GET }
        
        var mockResponse:  CharacterListItem? { return .mockCharacterListItem }
        
        var characterId: Int
        
        init(characterId: Int) {
            self.characterId = characterId
        }
    }
    
}
