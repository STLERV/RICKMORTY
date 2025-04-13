//
//  CharactersListViewModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.

import SwiftUI

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError?
    @Published var searchQuery: String = ""
    
    private var currentPage = 1
    private var isLastPage = false
    
    private let characterService: CharacterServiceProtocol
    
    init(characterService: CharacterServiceProtocol = CharacterService()) {
        self.characterService = characterService
    }

    func fetchCharacters() async {
        guard !isLoading && !isLastPage else { return }
        startLoading()
        do {
            let page = try await loadCharacters()
            
            if page.isFromCache {
                errorMessage = IdentifiableError(message: "You're viewing offline data. Please reconnect.")
            }

            characters.append(contentsOf: page.characters)

            if !page.isFromCache {
                isLastPage = !page.hasMore
            }
            currentPage += 1
        } catch {
            errorMessage = IdentifiableError(message: error.localizedDescription)
        }
        stopLoading()
    }

    private func loadCharacters() async throws -> CharactersPage {
        if searchQuery.isEmpty {
            return try await characterService.fetchCharacters(page: currentPage)
        } else {
            return try await characterService.searchCharacters(name: searchQuery,
                                                               page: currentPage)
        }
    }

    func retryLoading() {
        errorMessage = nil
        Task {
            await fetchCharacters()
        }
    }

    func startSearch(with query: String) {
        reset()
        searchQuery = query
        Task {
            await fetchCharacters()
        }
    }

    func clearSearch() {
        startSearch(with: "")
    }

    private func startLoading() {
        isLoading = true
        errorMessage = nil
    }

    private func stopLoading() {
        isLoading = false
    }

    private func reset() {
        characters = []
        currentPage = 1
        isLastPage = false
    }
}
