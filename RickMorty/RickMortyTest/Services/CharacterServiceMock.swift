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
    var dummyCharacters: [CharacterDTO] = []

    func fetchCharacters(page: Int) async throws -> [CharacterDTO] {
        if shouldFail {
            throw NSError(domain: "mock", code: 1)
        }
        return dummyCharacters
    }
}
