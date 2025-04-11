//
//  CharactersService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) async throws -> [CharacterDTO]
}

class CharacterService: CharacterServiceProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchCharacters(page: Int) async throws -> [CharacterDTO] {
        return try await apiService.fetchCharacters(page: page)
    }
}
