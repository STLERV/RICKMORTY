//
//  CachedAsyncImage.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 12/4/25.
//
import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL?
    let placeholder: () -> Placeholder
    let content: (Image) -> Content

    @State private var uiImage: UIImage?

    var body: some View {
        Group {
            if let uiImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    private func loadImage() async {
        guard let url else { return }

        if let cached = ImageCache.shared.image(for: url) {
            uiImage = cached
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                ImageCache.shared.insertImage(image, for: url)
                uiImage = image
            }
        } catch {
            #if DEBUG
            print("Image load failed for \(url): \(error.localizedDescription)")
            #endif
        }
    }
}
