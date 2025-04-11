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

    private var currentPage = 1
    private let characterService: CharacterService
    private var isLastPage = false

    init(characterService: CharacterService = CharacterService()) {
        self.characterService = characterService
    }

    func fetchCharacters() async {
        do {
            //TODO: Loading
            let dtos = try await characterService.fetchCharacters(page: currentPage)
                      self.characters.append(contentsOf: dtos.map { Character(dto: $0) })
                      currentPage += 1
                      
                      if dtos.isEmpty {
                          isLastPage = true
                      }
                  } catch {
            //TODO: Error
        }
    }
}
