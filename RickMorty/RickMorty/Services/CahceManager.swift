//
//  CahceManager.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 12/4/25.
//
import Foundation

protocol CacheManagerProtocol {
    func saveCharacters(_ characters: [CharacterDTO], for page: Int) async
    func loadCharacters(for page: Int) async -> [CharacterDTO]?
}

final class CacheManager: CacheManagerProtocol {
    static let shared = CacheManager()

    private func fileURL(for page: Int) -> URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent("characters_page_\(page).json")
    }

    func saveCharacters(_ characters: [CharacterDTO], for page: Int) async {
        guard let url = fileURL(for: page) else { return }

        do {
            let data = try JSONEncoder().encode(characters)
            try data.write(to: url, options: .atomic)
        } catch {
            #if DEBUG
            print("Error saving characters page \(page): \(error.localizedDescription)")
            #endif
        }
    }

    func loadCharacters(for page: Int) async -> [CharacterDTO]? {
        guard let url = fileURL(for: page) else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CharacterDTO].self, from: data)
        } catch {
            #if DEBUG
            print("Error loading cached page \(page): \(error.localizedDescription)")
            #endif
            return nil
        }
    }
}
