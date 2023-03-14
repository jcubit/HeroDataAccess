//
//  JSONHeroRepositoryTests.swift
//  
//
//  Created by Javier Cuesta on 14.03.23.
//

import XCTest
@testable import HeroDataAccess
@testable import HeroDomain

final class JSONHeroRepositoryTests: XCTestCase {

    func test_fetchHeroes() async throws {
        // Setup
        let baseURL = fixturesDirectory().absoluteString
        let heroesURL = fixtureUrl(for: "heroes.json").absoluteString
        let heroRepository = JSONHeroRepository(baseURL: baseURL,
                                                heroesURL: heroesURL)

        // MUT
        let rawHeroes = try await heroRepository.fetchHeroes()
        XCTAssertEqual(rawHeroes, [RawHero.Mock.antimage, RawHero.Mock.axe, RawHero.Mock.bane])
    }

    func test_fetchImages() async throws {
        // Setup
        let baseURL = fixturesDirectory().absoluteString
        let heroesURL = fixtureUrl(for: "heroes.json").absoluteString
        let heroRepository = JSONHeroRepository(baseURL: baseURL,
                                                heroesURL: heroesURL)

        let imagesURLs = [fixtureUrl(for: "antimage.png"),
                          fixtureUrl(for: "axe.png"),
                          fixtureUrl(for: "bane.png"),
                          fixtureUrl(for: "antimageIcon.png"),
                          fixtureUrl(for: "axeIcon.png"),
                          fixtureUrl(for: "baneIcon.png")]
        let imagesPaths = imagesURLs.map({$0.absoluteString})

        // MUT
        let images = try await heroRepository.images(from: imagesPaths)

        // Verify
        XCTAssertEqual(images.count, 6)
        for url in imagesURLs {
            let image = try XCTUnwrap(images[url])
            XCTAssertNotNil(image)
            XCTAssertTrue(image.isValid)
        }
    }
}
