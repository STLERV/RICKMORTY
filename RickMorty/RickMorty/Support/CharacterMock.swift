//
//  CharacterMock.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 12/4/25.
//
import Foundation

extension Character {
    static let mockRick = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Unknown",
        species: "Human",
        type: "",
        gender: "Male",
        originName: "Earth (C-137)",
        locationName: "Citadel of Ricks",
        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        episodeCount: 51
    )
}

extension CharacterDTO {
    static let mockRickDto = CharacterDTO(
        id: 1,
        name: "Rick",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .init(name: "", url: ""),
        location: .init(name: "", url: ""),
        image: "",
        episode: [],
        url: "",
        created: ""
    )
    
}
