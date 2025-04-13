//
//  CharactersListView.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
// CharacterListView.swift
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(
                    text: $viewModel.searchQuery,
                    onSearch: {
                        viewModel.startSearch(with: viewModel.searchQuery)
                    },
                    onClear: {
                        viewModel.clearSearch()
                    }
                )

                ZStack {
                    List(viewModel.displayedCharacters) { character in
                        NavigationLink {
                            CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
                        } label: {
                            CharacterRow(character: character)
                        }
                        .onAppear {
                            if character.id == viewModel.characters.last?.id {
                                Task { await viewModel.fetchCharacters() }
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
            }
            .navigationTitle("Personajes")
        }
        .task {
            await viewModel.fetchCharacters()
        }
        .errorAlert(message: $viewModel.errorMessage) {
            viewModel.retryLoading()
        }
    }
}
