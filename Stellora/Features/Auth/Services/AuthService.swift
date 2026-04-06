//
//  AuthService.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation

final class AuthService {
    //    private let apiClient = APIClient.shared
    //
    //    func signup(name: String, email: String, password: String) async throws -> UserResponse {
    //        let request = SignupRequest(name: name, email: email, password: password)
    //        return try await apiClient.request(
    //            path:"api/v1/users/signup",
    //                method:"POST",
    //            body: request,
    //            responseType: UserResponse.self
    //        )
    //
    //    }
    //    func login(email: String, password: String) async throws -> LoginResponse {
    //        let request = LoginRequest(email: email, password: password)
    //        return try await apiClient.request(
    //            path:"api/v1/users/login",
    //            method: "POST",
    //            body: request,
    //            responseType: LoginResponse.self
    //            )
    //    }
    func signup(name: String, email: String, password: String) async throws -> SignupResponse {
        
        print("Api call initiated...")
        // Request Object
        let request = SignupRequest(name: name, email: email, password: password)
        // establish URL object
        guard let url = URL(string: AppConfig.baseURL + "api/v1/users/signup") else {
            throw URLError(.badURL)
        }
        // URL wrapper
        var urlRequest = URLRequest(url: url)
        
        // add method to http method
        urlRequest.httpMethod = "POST"
        // add header Content-Type = application/json
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // add body to http request
        urlRequest.httpBody = try JSONEncoder().encode(request)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if(200...299).contains(httpResponse.statusCode){
            return try JSONDecoder().decode(SignupResponse.self, from: data)
        }
        else {
            
            if let apiError = try? JSONDecoder().decode(SignupResponseError.self, from: data){
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                    NSLocalizedDescriptionKey: apiError.message
                ])
            }
            else {
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                    NSLocalizedDescriptionKey: "Something went wrong. Please try again."
                ])
            }
        }
        
        
    }
    
}
