//
//  CharacterDetalViewModelTests.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 12/4/25.
//
import XCTest
import SwiftUI
@testable import RickMorty


@MainActor
final class CharacterDetailViewModelTests: XCTestCase {

    private var sut: CharacterDetailViewModel!

    override func setUpWithError() throws {
        sut = CharacterDetailViewModel(character: .mockRick)
    }

    func test_init_mapsCharacterCorrectly() {
        XCTAssertEqual(sut.title, "Rick Sanchez")
        XCTAssertEqual(sut.episodesCount, "51")
        XCTAssertEqual(sut.location, "Citadel of Ricks")
        XCTAssertEqual(sut.type, "N/A")
        XCTAssertEqual(sut.statusColor, .gray)
    }
}
