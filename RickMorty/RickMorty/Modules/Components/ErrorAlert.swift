//
//  ErrorAlert.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}

struct ErrorAlert: ViewModifier {
    @Binding var error: IdentifiableError?
    let onRetry: () -> Void

    func body(content: Content) -> some View {
        content
            .alert(item: $error) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.message),
                    primaryButton: .default(Text("Retry"), action: onRetry),
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
    }
}

extension View {
    func errorAlert(error: Binding<IdentifiableError?>, onRetry: @escaping () -> Void) -> some View {
        self.modifier(ErrorAlert(error: error, onRetry: onRetry))
    }
}
