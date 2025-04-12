//
//  ErrorAlert.swift
//  RickMorty
//
//  Created by AnnaPersonalDev on 11/4/25.
//
import SwiftUI

struct ErrorAlert: ViewModifier {
    @Binding var message: String?
    let onRetry: () -> Void

    func body(content: Content) -> some View {
        content
            .alert("Error",
                   isPresented: Binding<Bool>(
                       get: { message != nil },
                       set: { if !$0 { message = nil } }
                   ),
                   actions: {
                       Button("Retry", action: onRetry)
                       Button("Cancel", role: .cancel) {
                           message = nil
                       }
                   },
                   message: {
                       Text(message ?? "")
                   })
    }
}

extension View {
    func errorAlert(message: Binding<String?>, onRetry: @escaping () -> Void) -> some View {
        self.modifier(ErrorAlert(message: message, onRetry: onRetry))
    }
}
