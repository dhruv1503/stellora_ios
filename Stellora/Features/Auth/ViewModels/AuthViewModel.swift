//
//  AuthViewModel.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false

    private let authService = AuthService()

    init() {
        isAuthenticated = KeychainService.shared.getToken() != nil
    }

    func signup() async {
        isLoading = true
        errorMessage = nil

        do {
            _ = try await authService.signup(
                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func login() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await authService.login(
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
            KeychainService.shared.saveToken(response.accessToken)
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func logout() {
        KeychainService.shared.deleteToken()
        isAuthenticated = false
    }
}
