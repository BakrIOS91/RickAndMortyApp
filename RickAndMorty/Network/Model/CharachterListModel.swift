//
//  CharachterListModel.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 02/09/2025.
//

import Foundation

// MARK: - CharacterList
struct CharacterList: Codable {
    let info: PaginationInfo
    let results: [CharacterListItem]
    
    static let mockCharacterList = CharacterList(
        info: .mockPaginationInfo,
        results: CharacterListItem.mockCharacterListItemArray
    )
}

// MARK: - Info
struct PaginationInfo: Codable {
    let count, pages: Int
    
    // MARK: - Mock Data
    static let mockPaginationInfo = PaginationInfo(
        count: 826,
        pages: 42
    )
}

// MARK: - Result
struct CharacterListItem: Codable {
    let id: Int
    let name: String
    let status: Status
    let species, type: String
    let gender: CharacterGender
    let origin, location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static let mockCharacterListItem = CharacterListItem(
        id: 781,
        name: "Rick's Garage",
        status: .alive,
        species: "Robot",
        type: "Artificial Intelligence",
        gender: .female,
        origin: CharacterLocation(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
        location: CharacterLocation(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
        image: "https://rickandmortyapi.com/api/character/avatar/781.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/49"],
        url: "https://rickandmortyapi.com/api/character/781",
        created: "2021-10-25T09:18:48.188Z"
    )

    static let mockCharacterListItemArray: [CharacterListItem] = [
        CharacterListItem(
            id: 781,
            name: "Rick's Garage",
            status: .alive,
            species: "Robot",
            type: "Artificial Intelligence",
            gender: .female,
            origin: CharacterLocation(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
            location: CharacterLocation(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
            image: "https://rickandmortyapi.com/api/character/avatar/781.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/49"],
            url: "https://rickandmortyapi.com/api/character/781",
            created: "2021-10-25T09:18:48.188Z"
        ),
        CharacterListItem(
            id: 782,
            name: "Memory Squanchy",
            status: .dead,
            species: "Alien",
            type: "Memory",
            gender: .male,
            origin: CharacterLocation(name: "Birdperson's Consciousness", url: "https://rickandmortyapi.com/api/location/120"),
            location: CharacterLocation(name: "Birdperson's Consciousness", url: "https://rickandmortyapi.com/api/location/120"),
            image: "https://rickandmortyapi.com/api/character/avatar/782.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/49"],
            url: "https://rickandmortyapi.com/api/character/782",
            created: "2021-10-25T09:20:57.545Z"
        ),
        CharacterListItem(
            id: 783,
            name: "Memory Rick",
            status: .dead,
            species: "Human",
            type: "Memory",
            gender: .male,
            origin: CharacterLocation(name: "Birdperson's Consciousness", url: "https://rickandmortyapi.com/api/location/120"),
            location: CharacterLocation(name: "Birdperson's Consciousness", url: "https://rickandmortyapi.com/api/location/120"),
            image: "https://rickandmortyapi.com/api/character/avatar/783.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/49"],
            url: "https://rickandmortyapi.com/api/character/783",
            created: "2021-10-25T09:22:40.448Z"
        )
    ]
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    
    var localizedString: String {
        switch self {
        case .female:
            return Str.characterGenderFemale.text
        case .male:
            return Str.characterGenderMale.text
        case .unknown:
            return Str.characterGenderUnknown.text
        }
    }
}

// MARK: - Location
struct CharacterLocation: Codable {
    let name: String
    let url: String
    
    static let mockLocation: CharacterLocation = CharacterLocation(
        name: "Birdperson's Consciousness",
        url: "https://rickandmortyapi.com/api/location/120"
    )
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    
    var localizedString: String {
        switch self {
        case .alive:
            return Str.characterStatusAlive.text
        case .dead:
            return Str.characterStatusDead.text
        }
    }
}
