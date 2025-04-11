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
    private let characterService: CharacterServiceProtocol
    private var isLastPage = false

    init(characterService: CharacterServiceProtocol = CharacterService()) {
        self.characterService = characterService
    }

    func fetchCharacters() async {
        guard !isLoading && !isLastPage else { return }

        isLoading = true
        errorMessage = nil

        do {
            let dtos = try await characterService.fetchCharacters(page: currentPage)
            let newCharacters = dtos.map { Character(dto: $0) }

            characters.append(contentsOf: newCharacters)
            currentPage += 1

            if dtos.isEmpty {
                isLastPage = true
            }
        } catch {
            errorMessage = "Ha ocurrido un error. Inténtalo de nuevo."
        }

        isLoading = false
    }

    func dismissError() {
        errorMessage = nil
    }
    
    func retryLoading() {
        Task {
            await fetchCharacters()
        }
    }
}
