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
    let imageURL: URL?
    let status: String
    let species: String

    init(dto: CharacterDTO) {
        self.id = dto.id
        self.name = dto.name
        self.imageURL = URL(string: dto.image)
        self.status = dto.status
        self.species = dto.species
    }
}
