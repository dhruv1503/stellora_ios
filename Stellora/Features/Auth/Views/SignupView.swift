//
//  SignupView.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//
import Foundation
import SwiftUI



struct SignupView: View {
//    @ObservedObject var viewModel: AuthViewModel
    
    @StateObject var viewModel = AuthViewModel()
    
    
    
    
//    @State private var name: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
//    @State private var errorMessages: SignUpErrors = SignUpErrors()
//    @State private var isValidating: Bool = false
    
    
//    func validateForm() -> Void {
//        isValidating = true
//        // Outdated
////        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//        
//        Task{
//            try? await Task.sleep(nanoseconds: 2_000_000_000)
//            var errors : SignUpErrors = SignUpErrors()
//            if name.isEmpty {
//                print("Name is required")
//                errors.name = "Name is required"
//            }
//            else if(name.count > 120){
//                errors.name = "Name must be less than 120 characters"
//            }
//            if email.isEmpty {
//                errors.email = "Email is required"
//            }
//            else if !email.contains("@") {
//                errors.email = "Email is not valid"
//            }
//            
//            if password.isEmpty {
//                errors.password = "Password is required"
//            }
//            else if(password.count < 8 || password.count > 64){
//                errors.password = "Password must be between 8 and 64 characters"
//            }
//            if confirmPassword.isEmpty {
//                errors.confirmPassword = "Confirm password is required"
//            }
//            else if(password != confirmPassword){
//                errors.confirmPassword =  "Passwords do not match"
//            }
//            if( errors.name != nil ||
//                errors.email != nil ||
//                errors.password != nil ||
//                errors.confirmPassword != nil){
//                errorMessages = errors
//          
//                
//            }
//            
//            else{
//                print(print("SUCCESS → proceed to next screen"))
//            }
//            
//            isValidating = false
//            
//            
//        }
//        
//    }
    
    
    

    var body: some View {
        //        VStack(spacing: 16) {
        //            Text("Signup")
        //                .font(.largeTitle)
        //                .bold()
        //
        //            TextField("Name", text: $viewModel.name)
        //                .textFieldStyle(.roundedBorder)
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
        //            Button(viewModel.isLoading ? "Signing up..." : "Signup") {
        //                Task { await viewModel.signup() }
        //            }
        //            .disabled(viewModel.isLoading)
        //        }
        //        .padding()
        //    }
        
        VStack {
            Text("Create an account")
                .font(.largeTitle)
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                
                AppTextField(
                    title: "Full Name",
                    placeholder: "Enter Full Name",
                    text: $viewModel.name,
                    errorMessage: viewModel.errorMessages.name
                )
                AppTextField(
                    title: "Email Address",
                    placeholder: "Enter Email Address",
                    text: $viewModel.email,
                    errorMessage: viewModel.errorMessages.email
                )
                
                AppSecureField(
                    title: "Password",
                    placeholder: "Enter Password",
                    text: $viewModel.password,
                    errorMessage: viewModel.errorMessages.password
                )
                
                AppSecureField(
                    title: "Confirm Password",
                    placeholder: "Re-enter Password",
                    text: $viewModel.confirmPassword,
                    errorMessage: viewModel.errorMessages.confirmPassword
                )
                
                
                
                    
                    
            }.padding()
            
            Spacer()
            
            VStack{
                Button{
                    viewModel.validateForm()
                }
              
                label: {
                    HStack{
                        if viewModel.isValidating {
                                   ProgressView()
                                       .progressViewStyle(CircularProgressViewStyle(tint: .white))
                               }
                        Text("Register")
                    }
                }
                
            }.frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isValidating ? Color.gray.opacity(0.3) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .disabled(viewModel.isValidating)
                
        }
        
    }
}

#Preview {
    SignupView()
}
