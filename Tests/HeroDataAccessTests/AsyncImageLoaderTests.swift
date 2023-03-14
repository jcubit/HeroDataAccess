//
//  AsyncImageLoaderTests.swift
//  
//
//  Created by Javier Cuesta on 14.03.23.
//

import XCTest
@testable import HeroDataAccess

final class AsyncImageLoaderTests: XCTestCase {

    func test_images() async throws {
        // Setup
        let imageLoader = AsyncImageLoader()

        let urls = [fixtureUrl(for: "antimage.png"),
                    fixtureUrl(for: "axe.png"),
                    fixtureUrl(for: "bane.png"),
                    fixtureUrl(for: "antimageIcon.png"),
                    fixtureUrl(for: "axeIcon.png"),
                    fixtureUrl(for: "baneIcon.png")]

        // MUT
        let images = try await imageLoader.images(from: urls)

        // Verify
        XCTAssertEqual(images.count, 6)
        for url in urls {
            let image = try XCTUnwrap(images[url])
            XCTAssertNotNil(image)
            XCTAssertTrue(image.isValid)
        }
    }
}
