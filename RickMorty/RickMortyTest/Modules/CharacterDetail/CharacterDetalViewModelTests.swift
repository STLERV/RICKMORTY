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
        XCTAssertEqual(sut.status, "Alive")
        XCTAssertEqual(sut.type, "Scientist")
        XCTAssertEqual(sut.statusColor, .green)
        XCTAssertEqual(sut.episodesCount, "51")
        XCTAssertEqual(sut.location, "Citadel of Ricks")
    }

    func test_type_returnsNA_whenEmpty() {
        let character = Character(
            id: 1,
            name: "Morty",
            status: "Dead",
            species: "Human",
            type: "",
            gender: "Male",
            originName: "Earth",
            locationName: "Unknown",
            imageURL: nil,
            episodeCount: 0
        )

        sut = CharacterDetailViewModel(character: character)
        XCTAssertEqual(sut.type, "N/A")
        XCTAssertEqual(sut.statusColor, .red)
    }

    func test_statusColor_returnsGray_forUnknownStatus() {

        let character = Character(
            id: 3,
            name: "Alien",
            status: "unknown",
            species: "Alien",
            type: "Blob",
            gender: "Unknown",
            originName: "???",
            locationName: "???",
            imageURL: nil,
            episodeCount: 5
        )
        sut = CharacterDetailViewModel(character: character)

        XCTAssertEqual(sut.statusColor, .gray)
    }
}
