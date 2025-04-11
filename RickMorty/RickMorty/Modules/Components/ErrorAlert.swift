//
//  ErrorAlert.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

struct ErrorAlert: ViewModifier {
    let errorMessage: String?
    let onRetry: () -> Void
    let onDismiss: () -> Void

    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: .constant(errorMessage != nil), actions: {
                Button("Reintentar") {
                    onRetry()
                }
                Button("Cancelar", role: .cancel) {
                    onDismiss()
                }
            }, message: {
                Text(errorMessage ?? "")
            })
    }
}

extension View {
    func errorAlert(message: String?, onRetry: @escaping () -> Void, onDismiss: @escaping () -> Void) -> some View {
        self.modifier(ErrorAlert(errorMessage: message, onRetry: onRetry, onDismiss: onDismiss))
    }
}
