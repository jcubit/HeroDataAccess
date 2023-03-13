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
    private let openDotaBaseURL: URL
    private let heroURLs: URL
    private var imageLoader = AsyncImageLoader()

    public init(openDotaBaseURL: String, heroURLs: String) {
        guard let openDotaBaseURL = URL(string: openDotaBaseURL)
        else { fatalError("Could not init URL with string: \(openDotaBaseURL)") }
        guard let heroURLs = URL(string: heroURLs)
        else { fatalError("Could not init URL with string: \(heroURLs)") }
        self.heroURLs = heroURLs
        self.openDotaBaseURL = openDotaBaseURL
    }

    public func fetchHeroes() async throws -> [RawHero] {
        let (data, response) = try await URLSession.shared.data(from: heroURLs)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw LoadingErrors.invalidServerResponse }

        let heroes = try JSONDecoder().decode([RawHero].self, from: data)
        return heroes
    }

    public func images(from urls: [String]) async throws -> [URL: HeroImage] {
        let fullURL = urls.compactMap({ URL(string: $0, relativeTo: openDotaBaseURL)})
        return try await imageLoader.images(from: fullURL)
    }

}

