//
//  CharactersListViewModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []

    private let apiService: APIService

    init(apiService: APIService = DefaultAPIService()) {
        self.apiService = apiService
    }

    func fetchCharacters() async {
        do {
            //TODO: Loading
            let response = try await apiService.fetchCharacters()
            self.characters = response.map { Character(dto: $0) }
        } catch {
            //TODO: Error
        }
    }
}
