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
        
        var requestTask: RequestTask {
            return .parameters([
                "page": pageIndex
            ])
        }
        
        init(pageIndex: Int) {
            self.pageIndex = pageIndex
        }
    }
    
}
