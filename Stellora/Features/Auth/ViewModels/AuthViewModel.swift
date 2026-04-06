////
////  AuthViewModel.swift
////  Stellora
////
////  Created by Dhruv Aggarwal on 22/03/26.
////
//
//import Foundation
//import Combine
//
//@MainActor
//final class AuthViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var name = ""
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    @Published var isAuthenticated = false
//
//    private let authService = AuthService()
//
//    init() {
//        isAuthenticated = KeychainService.shared.getToken() != nil
//    }
//
//    func signup() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            _ = try await authService.signup(
//                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
//                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
//                password: password
//            )
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//
//        isLoading = false
//    }
//
//    func login() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            let response = try await authService.login(
//                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
//                password: password
//            )
//            KeychainService.shared.saveToken(response.accessToken)
//            isAuthenticated = true
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//
//        isLoading = false
//    }
//
//    func logout() {
//        KeychainService.shared.deleteToken()
//        isAuthenticated = false
//    }
//}

import Foundation
import SwiftUI
import Combine

struct SignUpErrors {
    var name: String? = nil
    var email: String? = nil
    var password: String? = nil
    var confirmPassword: String? = nil
}

enum Route {
    case dashboard
}

@MainActor // run on UI thread
final class AuthViewModel: ObservableObject {
    func printHello() {
        print("Hello from AuthViewModel")
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var errorMessages: SignUpErrors = SignUpErrors()
    @Published var isValidating: Bool = false
    @Published var isValidated: Bool = false
    @Published var route: Route? = nil
    @Published var serverErrorMessage : String? = nil
    @Published var isLoading: Bool = false
    
    func validateForm() {
        isValidating = true // this is not happening on background as it is wrapped outside Task
        isValidated = false
        
        // runs on background thread, hence changes might not be updated on main thread, hence MainActor.run is required,
        // does it mean all the await tasking is happening on some other thread and when MainActor is called, main thread is notified to update changes?
        Task {
           
            
            var errors = SignUpErrors()
            
            if name.isEmpty {
                errors.name = "Name is required"
            } else if name.count > 120 {
                errors.name = "Name must be less than 120 characters"
            }
            
            if email.isEmpty {
                errors.email = "Email is required"
            } else if !email.contains("@") {
                errors.email = "Email is not valid"
            }
            
            if password.isEmpty {
                errors.password = "Password is required"
            } else if password.count < 8 || password.count > 64 {
                errors.password = "Password must be between 8 and 64 characters"
            }
            
            if confirmPassword.isEmpty {
                errors.confirmPassword = "Confirm password is required"
            } else if password != confirmPassword {
                errors.confirmPassword = "Passwords do not match"
            }
            
            let hasErrors =
                errors.name != nil ||
                errors.email != nil ||
                errors.password != nil ||
                errors.confirmPassword != nil
            
            // MainActor.run, is no longer required as all the comput is happening on main thread after we used @MainActor decorator
//            await MainActor.run {
//                self.errorMessages = errors
//                self.isValidating = false
//                
//                if !hasErrors {
//                    self.isValidated = true
//                    print("SUCCESS → proceed to next screen")
//                   
//                }
//            }
            
                           self.errorMessages = errors
                           self.isValidating = false
           
                           if !hasErrors {
                               self.isValidated = true
                               self.isLoading = true
                               Task {
                                   serverErrorMessage = nil
                                   do {
                                      let response =  try await AuthService().signup(
                                        name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                                        password: password
                                       )
                                       
                                       print("Sign up suceess:", response.email)
                                   }
                                   catch{
                                       self.serverErrorMessage = error.localizedDescription
                                   }
                                   self.isLoading = false
                               }
//                               self.route = .dashboard
//                               print("SUCCESS → proceed to next screen")
           
                           }
        }
    }
}


/*
 Q1 - does it mean all the await tasking is happening on some other thread and when MainActor is called, main thread is notified to update changes? [if, @MainActor is not used and Task {} is wrapped]
 
 Q2- Does this mean below code
 
 
 self.isValidating = true
 
 is not happening on background as it is wrapped outside Task [when not wrapped is Task]
 
 Q3- after @MainActor, will Task{} happen on UI thread, even sleep?
 
 
 */
