//
//  UserResponse.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//
import Foundation

struct UserResponse : Decodable {
    let userId : UUID
    let name : String
    let email : String
    let emailVerified : Bool
}
