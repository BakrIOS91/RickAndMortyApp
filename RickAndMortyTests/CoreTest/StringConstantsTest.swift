//
//  StringConstantsTest.swift
//  RickAndMorty
//
//  Created by Bakr Mohamed on 02/09/2025.
//

import Testing
import SwiftUI
@testable import RickAndMorty

struct StringConstantsTest {
    
    // MARK: - Helpers
    /// Utility to assert a SwiftUI view is actually a `Text`.
    private func assertIsText(_ view: some View) {
        #expect(view is Text, "Expected view to be Text")
    }
    
    // MARK: - Tests
    
    @Test("LocalizedString.text returns localized value")
    func localizedStringText() async throws {
        // Given
        let localized = LocalizedString(table: "Localizable", lookupKey: "hello_key")
        
        // When
        let result = localized.text
        
        // Then
        #expect(result == "Hello")
    }

    @Test("LocalizedString.key returns expected LocalizedStringKey")
    func localizedStringKey() {
        // Given
        let lookupKey = "hello_key"
        let localized = LocalizedString(table: "Localizable", lookupKey: lookupKey)
        
        // When
        let key = localized.key
        
        // Then
        #expect(key == LocalizedStringKey("Hello"))
    }

    @Test("LocalizedString.textView renders expected Text")
    func localizedStringTextView() {
        // Given
        let localized = LocalizedString(table: "Localizable", lookupKey: "hello_key")
        
        // When
        let result = localized.textView
        let plainText = localized.text
        
        // Then
        #expect(plainText == "Hello")
        assertIsText(result)
    }

    @Test("String.localizedStringKey extension creates matching key")
    func stringLocalizedStringKeyExtension() {
        // Given
        let lookupKey = "hello_key"
        
        // When
        let key = lookupKey.localizedStringKey
        
        // Then
        #expect(key == LocalizedStringKey(lookupKey))
    }

    @Test("LocalizedStringKey.textView creates Text that matches key")
    func localizedStringKeyTextViewExtension() {
        // Given
        let lookupKey = "hello_key"
        let key = lookupKey.localizedStringKey

        // When
        let textView = key.textView
        
        // Then
        assertIsText(textView)
    }
}
