//
//  SignupView.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Signup")
                .font(.largeTitle)
                .bold()

            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
            }

            Button(viewModel.isLoading ? "Signing up..." : "Signup") {
                Task { await viewModel.signup() }
            }
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}
