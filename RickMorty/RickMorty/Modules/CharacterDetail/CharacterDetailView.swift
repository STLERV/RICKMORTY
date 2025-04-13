//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                CachedAsyncImage(
                    url: viewModel.imageURL,
                    placeholder: {
                        ProgressView()
                    },
                    content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                    }
                )
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 18) {
                    Text(viewModel.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    DetailRow(label: "Status",
                              value: viewModel.status,
                              statusColor: viewModel.statusColor)
                    DetailRow(label: "Species", value: viewModel.species)
                    DetailRow(label: "Gender", value: viewModel.gender)
                    DetailRow(label: "Type", value: viewModel.type)
                    DetailRow(label: "Origin", value: viewModel.origin)
                    DetailRow(label: "Location", value: viewModel.location)
                    DetailRow(label: "Episodes", value: viewModel.episodesCount)
                }
                .padding()
            }
        }
    }
}

private struct DetailRow: View {
    let label: String
    let value: String
    var statusColor: Color? = nil
    
    var body: some View {
        HStack {
            Text("\(label):")
                .fontWeight(.semibold)
            if let color = statusColor {
                Circle()
                    .fill(color)
                    .frame(width: 16, height: 16)
                Text(value)
                    .foregroundColor(.gray)
            } else {
                Text(value)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    CharacterDetailView(viewModel: CharacterDetailViewModel(character: .mockRick))
}
