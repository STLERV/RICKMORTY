//
//  CharacterListViewModelTets.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import XCTest
@testable import RickMorty

@MainActor
final class CharacterListViewModelTests: XCTestCase {

    private var sut: CharacterListViewModel!
    private var mockService: MockCharacterService!

    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        sut = CharacterListViewModel(characterService: mockService)
    }

    func test_fetchCharacters_successfullyAddsCharacters() async {
        mockService.dummyCharacters = [
            CharacterDTO(id: 1,
                         name: "Rick",
                         status: "Alive",
                         species: "Human",
                         type: "",
                         gender: "Male",
                         origin: LocationDTO(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                         location: LocationDTO(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                         image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                         episode: [
                           "https://rickandmortyapi.com/api/episode/1",
                           "https://rickandmortyapi.com/api/episode/2"
                         ],
                         url: "https://rickandmortyapi.com/api/character/1",
                         created: "2017-11-04T18:48:46.250Z"
                   )
               ]

        await sut.fetchCharacters()

        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first?.name, "Rick")
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_fetchCharacters_setsErrorMessageOnFailure() async {

        mockService.shouldFail = true

        await sut.fetchCharacters()

        XCTAssertEqual(sut.characters.count, 0)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_fetchCharacters_doesNotFetchIfAlreadyLoading() async {

        sut.isLoading = true
        await sut.fetchCharacters()
        XCTAssertEqual(sut.characters.count, 0)
    }

    func test_fetchCharacters_doesNotFetchIfLastPageAlreadyLoaded() async {

        mockService.dummyCharacters = []
        await sut.fetchCharacters()
        XCTAssertEqual(sut.characters.count, 0)
    }

    func test_dismissError_setsErrorMessageToNil() {

        sut.errorMessage = "Error"
        sut.dismissError()
        XCTAssertNil(sut.errorMessage)
    }
}
