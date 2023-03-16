//
//  JSONHeroRepository.swift
//  HeroDataAccess
//
//  Created by Javier Cuesta on 13.03.23.
//

import HeroDomain
import Foundation

/// Implements the ``HeroRepository`` protocol that the
/// domain layer owns. It uses an asynchronous image loader
public final class JSONHeroRepository: HeroRepository {
    private let baseURL: URL
    private let heroesURL: URL
    private var imageLoader = AsyncImageLoader()

    public init(baseURL: String, heroesURL: String) {
        guard let baseURL = URL(string: baseURL)
        else { fatalError("Could not init URL with string: \(baseURL)") }
        guard let heroURLs = URL(string: heroesURL)
        else { fatalError("Could not init URL with string: \(heroesURL)") }
        self.heroesURL = heroURLs
        self.baseURL = baseURL
    }

    public func fetchHeroes() async throws -> [RawHero] {
        let (data, response) = try await URLSession.shared.data(from: heroesURL)

        if let httpResponse = response as? HTTPURLResponse {
            guard httpResponse.statusCode == 200
            else { throw FetchErrors.invalidServerResponse }
        }

        let heroes = try JSONDecoder().decode([RawHero].self, from: data)
        return heroes
    }

    public func images(from urls: [String]) async throws -> [URL: HeroImage] {
        let fullURL = urls.compactMap({ URL(string: $0, relativeTo: baseURL)})
        return try await imageLoader.images(from: fullURL)
    }
}

