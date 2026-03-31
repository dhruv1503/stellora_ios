//
//  LoginResponse.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation

struct LoginResponse: Decodable {
    let userId: UUID
    let accessToken: String
    let tokenType: String
}
