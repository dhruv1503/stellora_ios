////
////  LoginView.swift
////  Stellora
////
////  Created by Dhruv Aggarwal on 22/03/26.
////
//
//import SwiftUI
//
//struct LoginView: View {
//    @ObservedObject var viewModel: AuthViewModel
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Login")
//                .font(.largeTitle)
//                .bold()
//
//            TextField("Email", text: $viewModel.email)
//                .textInputAutocapitalization(.never)
//                .autocorrectionDisabled()
//                .textFieldStyle(.roundedBorder)
//
//            SecureField("Password", text: $viewModel.password)
//                .textFieldStyle(.roundedBorder)
//
//            if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundStyle(.red)
//                    .font(.footnote)
//            }
//
//            Button(viewModel.isLoading ? "Logging in..." : "Login") {
//                Task { await viewModel.login() }
//            }
//            .disabled(viewModel.isLoading)
//        }
//        .padding()
//    }
//}
