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
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            if !(200...299).contains(httpResponse.statusCode) {
                throw URLError(.init(rawValue: httpResponse.statusCode))
            }
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch {
            throw error
        }
    }
}
