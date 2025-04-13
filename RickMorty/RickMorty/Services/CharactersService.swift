//
//  CharactersService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) async throws -> CharactersPage
    func searchCharacters(name: String, page: Int) async throws -> CharactersPage
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
        let url = URL(string: "\(Endpoints.baseURL)/character?page=\(page)")!
        return try await loadCharacters(from: url, page: page)
    }

    func searchCharacters(name: String, page: Int) async throws -> CharactersPage {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        guard let url = URL(string: "\(Endpoints.baseURL)/character?page=\(page)&name=\(encoded)") else {
            throw URLError(.badURL)
        }
        
        do {
            return try await loadCharacters(from: url, page: page, isSearch: true)
        } catch {
            if let nsError = error as NSError?, nsError.code == 404 {
                return CharactersPage(
                    characters: [],
                    hasMore: false,
                    isFromCache: false
                )
            }
            throw error
        }
    }

    private func loadCharacters(from url: URL, page: Int, isSearch: Bool = false) async throws -> CharactersPage {
        do {
            let response: CharacterResponse = try await apiService.request(url)
            if !isSearch {
                await cacheManager.saveCharacters(response.results, for: page)
            }
            return CharactersPage(
                characters: response.results.map { Character(dto: $0) },
                hasMore: response.info.next != nil,
                isFromCache: false
            )
        } catch {
            if !isSearch,
               let cached = await cacheManager.loadCharacters(for: page),
               !cached.isEmpty {
                return CharactersPage(
                    characters: cached.map { Character(dto: $0) },
                    hasMore: true,
                    isFromCache: true
                )
            }
            throw error
        }
    }
}
