//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Imagen
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.1)
                        ProgressView()
                    }
                    .frame(height: 300)
                }

                VStack(alignment: .leading, spacing: 18) {
                    Text(viewModel.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .center)

                    DetailRow(label: "Status", value: viewModel.status, statusColor: viewModel.statusColor)
                    DetailRow(label: "Species", value: viewModel.species)
                    DetailRow(label: "Gender", value: viewModel.gender)
                    DetailRow(label: "Type", value: viewModel.type)
                    DetailRow(label: "Origin", value: viewModel.origin)
                    DetailRow(label: "Location", value: viewModel.location)
                    DetailRow(label: "Episodes", value: viewModel.episodesCount)
                }
            
                .background(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .shadow(radius: 5)
                .padding()
            }
        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("")
//        .navigationBarTitleDisplayMode(.inline)
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
//                Spacer()
                Text(value)
                    .foregroundColor(.gray)
            }
//            Spacer()
        }
    }
}
