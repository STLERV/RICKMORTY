//
//  CharactersListModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//

import Foundation

struct CharactersPage {
    let characters: [Character]
    let hasMore: Bool
    let isFromCache: Bool

    init(characters: [Character], hasMore: Bool, isFromCache: Bool = false) {
        self.characters = characters
        self.hasMore = hasMore
        self.isFromCache = isFromCache
    }
}

struct Character: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let originName: String
    let locationName: String
    let imageURL: URL?
    let episodeCount: Int


    init(dto: CharacterDTO) {
        self.id = dto.id
        self.name = dto.name
        self.status = dto.status
        self.species = dto.species
        self.type = dto.type
        self.gender = dto.gender
        self.originName = dto.origin.name
        self.locationName = dto.location.name
        self.imageURL = URL(string: dto.image)
        self.episodeCount = dto.episode.count
    }

    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        originName: String,
        locationName: String,
        imageURL: URL?,
        episodeCount: Int
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.originName = originName
        self.locationName = locationName
        self.imageURL = imageURL
        self.episodeCount = episodeCount
    }
}
