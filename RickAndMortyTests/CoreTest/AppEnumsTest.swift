//
//  AppEnumsTests.swift
//  RickAndMortyTests
//
//  Created by Bakr Mohamed on 03/09/2025.
//

import Testing
import SwiftUI
import BMSwiftNetworking
@testable import RickAndMorty

struct AppEnumsTests {
    
    // MARK: - ViewState.failHandler
    
    @Test("failHandler returns .unExpectedError for invalidURL")
    func failHandlerInvalidURL() {
        // Given
        let error = APIError.invalidURL
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .unExpectedError)
    }
    
    @Test("failHandler returns .unExpectedError for dataConversionFailed")
    func failHandlerDataConversionFailed() {
        // Given
        let error = APIError.dataConversionFailed
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .unExpectedError)
    }
    
    @Test("failHandler returns .serverError for httpError notAuthorize")
    func failHandlerHTTPNotAuthorized() {
        // Given
        let error = APIError.httpError(statusCode: .notAuthorize)
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .serverError)
    }
    
    @Test("failHandler returns .serverError for httpError other codes")
    func failHandlerHTTPOther() {
        // Given
        let error = APIError.httpError(statusCode: .notAuthorize)
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .serverError)
    }
    
    @Test("failHandler returns .noNetwork for noNetwork error")
    func failHandlerNoNetwork() {
        // Given
        let error = APIError.noNetwork
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .noNetwork)
    }
    
    @Test("failHandler returns .unExpectedError for unknown errors")
    func failHandlerDefaultCase() {
        // Given
        let error = APIError.invalidResponse
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .unExpectedError)
    }
    
    @Test("failHandler returns .searchError for notFound errors")
    func failSearchErrorCase() {
        // Given
        let error = APIError.httpError(statusCode: .notFound)
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .searchError)
    }
    
    
    @Test("failHandler returns .serverError for default HTTP errors")
    func failHandlerDefaultHTTPCase() {
        // Given
        let error = APIError.httpError(statusCode: .redirection)
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .serverError)
    }
    
    @Test("failHandler returns .unExpectedError for String Conversion Failed ")
    func failHandlerStringConversionFailedCase() {
        // Given
        let error = APIError.stringConversionFailed
        
        // When
        let state = ViewState.failHandler(error)
        
        // Then
        #expect(state == .unExpectedError)
    }
    
    // MARK: - Page Enum
    
    @Test("Page enum equality works as expected")
    func pageEnumEquality() {
        // Given / When / Then
        #expect(Page.first != Page.next)
    }
    
    // MARK: - ViewState Equatable
    
    @Test("ViewState Equatable comparison works")
    func viewStateEquatable() {
        // Given
        let state1 = ViewState.loading
        let state2 = ViewState.loading
        let state3 = ViewState.noData
        
        // When / Then
        #expect(state1 == state2)
        #expect(state1 != state3)
    }
}
