//
//  ChractersRequestTests.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import Testing
@testable import RickAndMorty
import BMSwiftNetworking

struct ChractersRequestTests {
    
    @Test("Verify GetCharacters baseURL")
    func testBaseURL() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1, searchText: "Rick")
        
        // When
        let baseURL = request.baseURL
        
        // Then
        #expect(baseURL == AppTarget().kBaseURL)
    }
    
    @Test("Verify GetCharacters requestPath")
    func testRequestPath() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1, searchText: "Rick")
        
        // When
        let path = request.requestPath
        
        // Then
        #expect(path == "/character")
    }
    
    @Test("Verify GetCharacters requestMethod")
    func testRequestMethod() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1, searchText: "Rick")
        
        // When
        let method = request.requestMethod
        
        // Then
        #expect(method == .GET)
    }
    
    @Test("Verify GetCharacters requestTask contains page and searchText")
    func testRequestTaskParameters() {
        // Given
        let pageIndex = 5
        let search = "Morty"
        let request = ChractersRequest.GetCharacters(pageIndex: pageIndex, searchText: search)
        
        // When
        let task = request.requestTask
        
        // Then
        if case let .parameters(params) = task {
            #expect(params["page"] as? Int == pageIndex)
            #expect(params["name"] as? String == search)
        } else {
            Issue.record("requestTask is not parameters task")
        }
    }
    
    @Test("Verify GetCharacters mockResponse is not nil")
    func testMockResponse() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1, searchText: "Rick")
        
        // When
        let mock = request.mockResponse
        
        // Then
        #expect(mock != nil)
    }
    
    @Test("Verify GetCharacters Response typealias")
        func testResponseType() {
            // Given
            typealias Response = ChractersRequest.GetCharacters.Response
            
            // When
            let responseType = Response.self
            
            // Then
            #expect(responseType == CharacterList?.self)
        }
}
