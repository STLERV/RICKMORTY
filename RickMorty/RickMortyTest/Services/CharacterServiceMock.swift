//
//  CharacterServiceMock.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import XCTest
@testable import RickMorty

final class MockCharacterService: CharacterServiceProtocol {

    var shouldFail = false
    var shouldReturnFromCache = false
    var dummyCharacters: [CharacterDTO] = []

    func fetchCharacters(page: Int) async throws -> CharactersPage {
        if shouldFail {
            throw NSError(domain: "mock", code: 1)
        }

        return CharactersPage(
            characters: dummyCharacters.map { Character(dto: $0) },
            hasMore: false,
            isFromCache: shouldReturnFromCache
        )
    }

    func searchCharacters(name: String, page: Int) async throws -> CharactersPage {
        if shouldFail {
            throw NSError(domain: "mock", code: 1)
        }

        return CharactersPage(
            characters: dummyCharacters.map { Character(dto: $0) },
            hasMore: false,
            isFromCache: shouldReturnFromCache
        )
    }
}
