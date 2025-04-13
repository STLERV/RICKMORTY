//
//  CharacterRow.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 13/4/25.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character

    var body: some View {
        HStack {
            CachedAsyncImage(
                url: character.imageURL,
                placeholder: {
                    ProgressView()
                },
                content: { image in image
                        .resizable()
                        .scaledToFill()
                }
            )
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(character.gender)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}
