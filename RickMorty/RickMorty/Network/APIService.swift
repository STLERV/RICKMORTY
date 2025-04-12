//
//  APIService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol APIServiceProtocol {
    func fetchCharacters(page: Int) async throws -> CharacterResponse
}

struct APIService: APIServiceProtocol {
    func fetchCharacters(page: Int) async throws -> CharacterResponse {
        guard let url = URL(string: "\(Endpoints.baseURL)/character?page=\(page)") else {
            throw NSError(domain: "NetworkError", code: 1001)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CharacterResponse.self, from: data)
    }
}
