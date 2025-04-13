//
//  APIService.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(_ url: URL) async throws -> T
}

struct APIService: APIServiceProtocol {
    func request<T: Decodable>(_ url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
