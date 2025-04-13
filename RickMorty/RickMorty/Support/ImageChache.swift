//
//  ImageChache.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 12/4/25.
//
import UIKit

final class ImageCache {
    static let shared = ImageCache()

    private init() {}

    private let cache = NSCache<NSString, UIImage>()

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url.absoluteString as NSString)
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image else { return }
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
