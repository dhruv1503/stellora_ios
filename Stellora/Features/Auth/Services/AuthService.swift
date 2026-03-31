//
//  AuthService.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation

final class AuthService {
    private let apiClient = APIClient.shared
    
    func signup(name: String, email: String, password: String) async throws -> UserResponse {
        let request = SignupRequest(name: name, email: email, password: password)
        return try await apiClient.request(
            path:"api/v1/users/signup",
                method:"POST",
            body: request,
            responseType: UserResponse.self
        )
        
    }
    func login(email: String, password: String) async throws -> LoginResponse {
        let request = LoginRequest(email: email, password: password)
        return try await apiClient.request(
            path:"api/v1/users/login",
            method: "POST",
            body: request,
            responseType: LoginResponse.self
            )
    }

}
