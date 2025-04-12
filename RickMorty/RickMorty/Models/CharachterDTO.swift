//
//  CharachterDTO.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//

import Foundation

struct CharacterDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationDTO
    let location: LocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationDTO: Codable {
    let name: String
    let url: String
}

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [CharacterDTO]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
