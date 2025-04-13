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
        mockService.dummyCharacters = [.mockRickDto]
        
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
    
    func test_startSearch_setsQueryAndFetchesCharacters() async {
        mockService.dummyCharacters = [.mockRickDto]
        
        sut.startSearch(with: "Rick")
        
        XCTAssertEqual(sut.characters.count, 0)
        XCTAssertNil(sut.characters.first)
        XCTAssertNil(sut.errorMessage)
        
        sut.searchQuery = "Rick"
        XCTAssertEqual(sut.searchQuery, "Rick")
        XCTAssertEqual(sut.characters.count, 0)
        XCTAssertNil(sut.characters.first)
        XCTAssertNil(sut.errorMessage)
    }

    func test_clearSearch_resetsSearchQueryAndFetchesCharacters() async {

        sut.searchQuery = "Rick"
        mockService.dummyCharacters = [.mockRickDto]
        
        sut.clearSearch()
        
        XCTAssertEqual(sut.searchQuery, "")
        XCTAssertEqual(sut.characters.count, 0)
    }
}
