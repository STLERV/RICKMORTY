//
//  CharactersService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

class CharacterService {
    private let apiService: APIService

    init(apiService: APIService = DefaultAPIService()) {
        self.apiService = apiService
    }

    func fetchCharacters(page: Int) async throws -> [CharacterDTO] {
        return try await apiService.fetchCharacters(page: page)
    }
}
