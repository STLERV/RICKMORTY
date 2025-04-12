//
//  CharactersListViewModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var currentPage = 1
    private var isLastPage = false

    private let characterService: CharacterServiceProtocol

    init(characterService: CharacterServiceProtocol = CharacterService()) {
        self.characterService = characterService
    }

    func fetchCharacters() async {
        guard shouldFetchNextPage else { return }

        startLoading()

        do {
            let page = try await characterService.fetchCharacters(page: currentPage)
            appendCharacters(from: page)
            handleCacheStatusIfNeeded(from: page)
        } catch {
            handleError()
        }

        stopLoading()
    }

    func retryLoading() {
        errorMessage = nil
        Task {
            await fetchCharacters()
        }
    }

    private var shouldFetchNextPage: Bool {
        let aa = !isLoading && !isLastPage
        print(aa)
       return  !isLoading && !isLastPage
    }

    private func startLoading() {
        isLoading = true
        errorMessage = nil
    }

    private func stopLoading() {
        isLoading = false
    }

    private func appendCharacters(from page: CharactersPage) {
        characters.append(contentsOf: page.characters)
        if !page.isFromCache {
            isLastPage = !page.hasMore
        }
        currentPage += 1
    }

    private func handleCacheStatusIfNeeded(from page: CharactersPage) {
        if page.isFromCache {
            errorMessage = "You're viewing offline data. Please reconnect to update."
        }
    }

    private func handleError() {
        errorMessage = "Error. Please try again."
    }
}
