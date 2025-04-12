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
        status: "Alive",
        species: "Human",
        type: "Scientist",
        gender: "Male",
        originName: "Earth (C-137)",
        locationName: "Citadel of Ricks",
        imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        episodeCount: 51
    )
}
