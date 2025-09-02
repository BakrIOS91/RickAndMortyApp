//
//  CharacterListModelTests.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import Foundation
import Testing
@testable import RickAndMorty

struct CharacterListModelTests {
    
    // MARK: - Helpers
    private func loadJSONData() -> Data {
        let json = """
        {
            "info": {
                "count": 826,
                "pages": 42,
                "next": "https://rickandmortyapi.com/api/character?page=3",
                "prev": "https://rickandmortyapi.com/api/character?page=1"
            },
            "results": [
                {
                    "id": 781,
                    "name": "Rick's Garage",
                    "status": "Alive",
                    "species": "Robot",
                    "type": "Artificial Intelligence",
                    "gender": "Female",
                    "origin": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "location": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/781.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/49"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/781",
                    "created": "2021-10-25T09:18:48.188Z"
                }
            ]
        }
        """
        return Data(json.utf8)
    }
    
    // MARK: - JSON Decoding
    
    @Test("Decodes CharacterList from sample JSON")
    func decodeCharacterList() throws {
        // Given
        let data = loadJSONData()
        
        // When
        let decoded = try JSONDecoder().decode(CharacterList.self, from: data)
        let first = try #require(decoded.results.first)
        
        // Then
        #expect(decoded.info.count == 826)
        #expect(decoded.info.pages == 42)
        #expect(decoded.results.count == 1)
        #expect(first.id == 781)
        #expect(first.name == "Rick's Garage")
        #expect(first.status == .alive)
        #expect(first.gender == .female)
        #expect(first.gender != .male)
        #expect(first.gender != .unknown)
        #expect(first.status != .dead)
    }
    
    @Test("Decoding fails with invalid JSON")
    func decodingFailsWithInvalidJSON() {
        // Given
        let badJSON = """
        { "wrong_key": "oops" }
        """.data(using: .utf8)!
        
        // When / Then
        #expect(throws: Error.self) {
            try JSONDecoder().decode(CharacterList.self, from: badJSON)
        }
    }
    
    // MARK: - Enum Localized Strings
    
    @Test("CharacterGender localizedString returns expected values")
    func characterGenderLocalizedStrings() {
        // Given
        let female = CharacterGender.female
        let male = CharacterGender.male
        let unknown = CharacterGender.unknown
        
        // When
        let femaleText = female.localizedString
        let maleText = male.localizedString
        let unknownText = unknown.localizedString
        
        // Then
        #expect(femaleText == Str.characterGenderFemale.text)
        #expect(maleText == Str.characterGenderMale.text)
        #expect(unknownText == Str.characterGenderUnknown.text)
    }
    
    @Test("Status localizedString returns expected values")
    func statusLocalizedStrings() {
        // Given
        let alive = Status.alive
        let dead = Status.dead
        
        // When
        let aliveText = alive.localizedString
        let deadText = dead.localizedString
        
        // Then
        #expect(aliveText == Str.characterStatusAlive.text)
        #expect(deadText == Str.characterStatusDead.text)
    }
    
    // MARK: - Mock Data Validation
    
    @Test("Mock CharacterList provides valid objects")
    func mockCharacterListIsValid() {
        // Given
        let mock = CharacterList.mockCharacterList
        
        // When
        let first = try! #require(mock.results.first)
        
        // Then
        #expect(mock.info.count == 826)
        #expect(mock.info.pages == 42)
        #expect(first.id == 781)
        #expect(!first.name.isEmpty)
        #expect(!first.episode.isEmpty)
    }
    
    @Test("Mock CharacterLocation provides valid object")
    func mockCharacterLocationIsValid() {
        // Given
        let location = CharacterLocation.mockLocation
        
        // When / Then
        #expect(!location.name.isEmpty)
        #expect(location.url.contains("api/location"))
    }
    
    @Test("Mock CharacterListItemArray contains valid data")
    func mockCharacterListItemArrayIsValid() {
        // Given
        let items = CharacterListItem.mockCharacterListItemArray
        
        // When / Then
        #expect(!items.isEmpty)
        for item in items {
            #expect(item.id > 0)
            #expect(!item.name.isEmpty)
            #expect(!item.species.isEmpty)
            #expect(!item.image.isEmpty)
            #expect(item.url.contains("api/character"))
        }
    }
}
