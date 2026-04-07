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


struct LoginErrorObj {
    var email: String?
    var password: String?
}


import SwiftUI

struct LoginView : View {
    
    @State var email : String = ""
    @State var password : String = ""
    @State var errorObj : LoginErrorObj = .init()
    @StateObject var authViewModel = AuthViewModel()
    
    func submitForm() -> Void {
        if(email.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            errorObj.email = "Email is required"
            return
        }
        else if !email.contains("@") {
            errorObj.email = "Email is not valid"
            return
        }
        
        if(password.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            errorObj.password = "Password is required"
            return
        }
        
        else if (password.count < 8 || password.count > 65) {
            errorObj.password = "Password must be between 8 to 65 characters"
            return
        }
        print("REACHED HERE")
        authViewModel.login(email: email, password: password)
    }
    
    
    
    
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Click here to login...")
                    .font(.largeTitle)
                
                Spacer()
                
                VStack {
                    AppTextField(
                        title: "Email",
                        placeholder: "Enter Email",
                        text: $email,
                        errorMessage: errorObj.email,
                        capitalization: .never,
                        autoCorrectionEnabled: false
                    )
                    AppSecureField(
                        title: "Password",
                        placeholder: "Enter Password",
                        text: $password,
                        errorMessage: errorObj.password
                    )
                    
                }
                .padding()
                
                Spacer()
                if let serverErrorMessage = authViewModel.serverErrorMessage,
                   !serverErrorMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    FormErrorBanner(message: serverErrorMessage)
                    
                }
                VStack{
                    Button {
                        submitForm()
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
                .disabled(authViewModel.isLoading)
                
            }
            .navigationDestination(item: $authViewModel.route){
                route in
                switch(route){
                case .dashboard:
                    DashboardView()
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
