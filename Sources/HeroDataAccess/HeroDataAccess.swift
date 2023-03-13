//
//  AsyncImageLoader.swift
//  HeroDataAccess
//
//  Created by Javier Cuesta on 13.03.23.
//

import Foundation
import HeroDomain

/// Fetch errors
public enum LoadingErrors: Error {
    case invalidServerResponse
    case unsupportedImage
}

/// Loads Images with a cache and asynchronous
public actor AsyncImageLoader {
    private var cache: [URL: CacheEntry] = [:]

    /// Loads a dictionary of hero images asynchronously
    func images(from urls: [URL]) async throws -> [URL: HeroImage] {
        var images = [URL: HeroImage](minimumCapacity: urls.count)
        try await withThrowingTaskGroup(of: (URL, HeroImage).self ) { group in
            for url in urls {
                _ = group.addTaskUnlessCancelled { [self] in
                    return (url, try await image(from: url))
                }
            }

            for try await (url, img) in group {
                images[url] = img
            }
        }
        return images
    }

    /// Loads a single image from a URL by first cheching if its cached
    func image(from url: URL) async throws -> HeroImage {
        if let cached = cache[url] {
            switch cached {
                case .ready(let image):
                    return image
                case .inProgress(let task):
                    return try await task.value
            }
        }

        let task = Task {
            try await loadImage(from: url)
        }

        cache[url] = .inProgress(task)
        do {
            let image = try await task.value
            cache[url] = .ready(image)
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }

    /// Loads a single image directly from a URL
    func loadImage(from url: URL) async throws -> HeroImage {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw LoadingErrors.invalidServerResponse }

        guard let image = HeroImage(data: data)
        else { throw LoadingErrors.unsupportedImage }
        return image
    }
}

extension AsyncImageLoader {
    /// A cache entry is *either* a the loading task or the loaded image
    private enum CacheEntry {
        case inProgress(Task<HeroImage, Error>)
        case ready(HeroImage)
    }
}
