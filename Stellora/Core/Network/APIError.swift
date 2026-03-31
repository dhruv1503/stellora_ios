//
//  ApiClient.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case server(String)
    case decoding(Error)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .server(let message): return message
        case .decoding(let error): return "Decoding Error: \(error)"
        case .network(let error): return "Network Error: \(error)"
        }
    }
}
