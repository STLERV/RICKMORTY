//
//  NameFilter.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 13/4/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void
    let onClear: () -> Void

    var body: some View {
        HStack {
            TextField("Search by name", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 8)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onClear()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }

            Button(action: onSearch) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
}
