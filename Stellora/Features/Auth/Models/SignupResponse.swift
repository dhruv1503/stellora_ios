//
//  SignupResponse.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 05/04/26.
//

struct SignupResponse : Codable {
    let id: String
    let name: String
    let email: String
    let emailVerified: Bool
    
}
