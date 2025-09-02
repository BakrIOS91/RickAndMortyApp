//
//  ChractersRequestTests.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//


import Testing
@testable import RickAndMorty

struct ChractersRequestTests {
    
    @Test("Verify GetCharacters baseURL")
    func testBaseURL() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1)
        
        // When
        let baseURL = request.baseURL
        
        // Then
        #expect(baseURL == AppTarget().kBaseURL)
    }
    
    @Test("Verify GetCharacters requestPath")
    func testRequestPath() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1)
        
        // When
        let path = request.requestPath
        
        // Then
        #expect(path == "/character")
    }
    
    @Test("Verify GetCharacters requestMethod")
    func testRequestMethod() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1)
        
        // When
        let method = request.requestMethod
        
        // Then
        #expect(method == .GET)
    }
    
    @Test("Verify GetCharacters requestTask parameters")
    func testRequestTaskParameters() {
        // Given
        let pageIndex = 5
        let request = ChractersRequest.GetCharacters(pageIndex: pageIndex)
        
        // When
        let task = request.requestTask
        
        // Then
        if case let .parameters(params) = task {
            #expect(params["page"] as? Int == pageIndex)
        } else {
            Issue.record("requestTask is not parameters task")
        }
    }
    
    @Test("Verify GetCharacters mockResponse is not nil")
    func testMockResponse() {
        // Given
        let request = ChractersRequest.GetCharacters(pageIndex: 1)
        
        // When
        let mock = request.mockResponse
        
        // Then
        #expect(mock != nil)
    }
}
