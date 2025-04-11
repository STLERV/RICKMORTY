//
//  CharactersListView.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.characters) { character in
                    NavigationLink {
                        CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
                    } label: {
                        HStack {
                            AsyncImage(url: character.imageURL) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading) {
                                Text(character.name)
                                    .font(.headline)
                                Text(character.species)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(character.status)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                        .onAppear {
                            if character.id == viewModel.characters.last?.id {
                                Task {
                                    await viewModel.fetchCharacters()
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)

                if viewModel.isLoading && viewModel.characters.isEmpty {
                    ProgressView("Cargando personajes...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .navigationTitle("Personajes")
        }
        .task {
            await viewModel.fetchCharacters()
        }
        .errorAlert(
            message: viewModel.errorMessage,
            onRetry: {
                Task {
                    await viewModel.fetchCharacters()
                }
            },
            onDismiss: {
                viewModel.dismissError()
            }
        )
    }
}
