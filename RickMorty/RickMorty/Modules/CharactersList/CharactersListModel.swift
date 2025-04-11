//
//  CharactersListModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//

import Foundation

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
}
