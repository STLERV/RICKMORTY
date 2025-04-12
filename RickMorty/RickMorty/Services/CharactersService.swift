//
//  CharactersService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) async throws -> CharactersPage
}

final class CharacterService: CharacterServiceProtocol {
    private let apiService: APIServiceProtocol
    private let cacheManager: CacheManagerProtocol

    init(
        apiService: APIServiceProtocol = APIService(),
        cacheManager: CacheManagerProtocol = CacheManager.shared
    ) {
        self.apiService = apiService
        self.cacheManager = cacheManager
    }

    func fetchCharacters(page: Int) async throws -> CharactersPage {
        do {
            let response = try await loadCharactersFromAPI(page: page)
            return CharactersPage(
                characters: response.results.map { Character(dto: $0) },
                hasMore: response.info.next != nil
            )
        } catch {
            return try await fallbackToCache(for: page, error: error)
        }
    }

    private func loadCharactersFromAPI(page: Int) async throws -> CharacterResponse {
        let response = try await apiService.fetchCharacters(page: page)

        if !response.results.isEmpty {
            await cacheManager.saveCharacters(response.results, for: page)
        }

        return response
    }

    private func fallbackToCache(for page: Int, error: Error) async throws -> CharactersPage {
        if let cached = await cacheManager.loadCharacters(for: page) {
            return CharactersPage(
                characters: cached.map { Character(dto: $0) },
                hasMore: true,
                isFromCache: true
            )
        }
        throw error
    }
}
