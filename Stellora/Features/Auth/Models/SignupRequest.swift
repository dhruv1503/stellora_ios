//
//  SignupRequest.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

struct SignupRequest: Encodable {
    let name: String
    let email: String
    let password: String
}
