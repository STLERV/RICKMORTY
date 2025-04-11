//
//  Endpoints.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://rickandmortyapi.com/api"

    static var characters: URL? {
        return URL(string: "\(baseURL)/character")
    }
}
