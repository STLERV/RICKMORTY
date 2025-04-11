//
//  APIService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol APIService {
    func fetchCharacters() async throws -> [CharacterDTO]
}

struct DefaultAPIService: APIService {
    func fetchCharacters() async throws -> [CharacterDTO] {
        guard let url = Endpoints.characters else {
            //TODO: handle error
            throw NSError(domain: "network error", code: 0, userInfo: nil) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}

