//
//  CharacterDetailViewModel.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation
import SwiftUI

@MainActor
final class CharacterDetailViewModel: ObservableObject {

    let character: Character

    init(character: Character) {
        self.character = character
    }

    var title: String {
        character.name
    }

    var imageURL: URL? {
        character.imageURL
    }

    var status: String {
        character.status
    }

    var species: String {
        character.species
    }

    var gender: String {
        character.gender
    }

    var type: String {
        character.type.isEmpty ? "N/A" : character.type
    }

    var origin: String {
        character.originName
    }

    var location: String {
        character.locationName
    }

    var episodesCount: String {
        "\(character.episodeCount)"
    }

    var statusColor: Color {
        switch character.status.lowercased() {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
}
