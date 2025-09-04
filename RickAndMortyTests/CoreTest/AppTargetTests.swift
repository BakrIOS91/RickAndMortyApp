//
//  AppTargetTests.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import Testing
@testable import RickAndMorty

struct AppTargetTests {
    
    @Test("AppTarget returns correct values for production environment")
    func productionTargetValues() {
        // Given
        var target = AppTarget()
        target.appEnvironment = .production
        
        // Then
        #expect(target.kAppHost == "rickandmortyapi.com")
        #expect(target.kMainAPIPath == "api")
        #expect(target.kAppScheme == "https")
    }
    
    @Test("AppTarget default values should not be empty")
    func nonEmptyDefaults() {
        // Given
        let target = AppTarget()
        
        // Then
        #expect(!target.kAppHost.isEmpty)
        #expect(target.kMainAPIPath != nil)
        #expect(!target.kAppScheme.isEmpty)
    }
}
