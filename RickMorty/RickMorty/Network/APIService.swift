//
//  APIService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol APIServiceProtocol {
    func fetchCharacters(page: Int) async throws -> [CharacterDTO]
}

struct APIService: APIServiceProtocol {
    func fetchCharacters(page: Int) async throws -> [CharacterDTO] {
        guard let url = URL(string: "\(Endpoints.baseURL)/character?page=\(page)") else {
            throw NSError(domain: "NetworkError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}

