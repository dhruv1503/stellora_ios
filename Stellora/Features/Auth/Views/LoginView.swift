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


import SwiftUI

struct LoginView : View {
    
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        
        VStack {
            Text("Click here to login...")
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                AppTextField(
                    title: "Email",
                    placeholder: "Enter Email",
                    text: $email,
                    errorMessage: nil,
                    capitalization: .never,
                    autoCorrectionEnabled: false
                )
                AppSecureField(
                    title: "Password",
                    placeholder: "Enter Password",
                    text: $password,
                    errorMessage: nil
                )
                
            }
            .padding()
            
            Spacer()
            
            VStack{
                Button {
                    
                }
                label: {
                    HStack{
                        Text("Login")
                    }
                    
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            
        }
    }
}


#Preview {
    LoginView()
}
