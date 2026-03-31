//
//  AppRouter.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 21/03/26.
//


import SwiftUI

struct AppRouter: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showSignup = false

    var body: some View {
        if authViewModel.isAuthenticated {
            VStack(spacing: 20) {
                Text("Logged in")
                    .font(.title)

                Button("Logout") {
                    authViewModel.logout()
                }
            }
        } else {
            NavigationStack {
                VStack(spacing: 24) {
                    if showSignup {
                        SignupView(viewModel: authViewModel)
                    } else {
                        LoginView(viewModel: authViewModel)
                    }

                    Button(showSignup ? "Already have an account? Login" : "New here? Signup") {
                        showSignup.toggle()
                        authViewModel.errorMessage = nil
                    }
                }
            }
        }
    }
}
