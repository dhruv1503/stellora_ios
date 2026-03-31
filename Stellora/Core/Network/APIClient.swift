//
//  APIClient.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 22/03/26.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func request<T: Decodable, U: Encodable>(
        path: String,
        method: String,
        body: U? = nil,
        token: String? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard let url = URL(string: AppConfig.baseURL + path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        print("----- API REQUEST -----")
        print("URL:", url.absoluteString)
        print("METHOD:", method)
        print("HEADERS:", request.allHTTPHeaderFields ?? [:])

        if let httpBody = request.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            print("BODY:", bodyString)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            print("----- API RESPONSE -----")
            print("STATUS:", httpResponse.statusCode)
            print("URL:", url.absoluteString)
            print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "nil")

            if (200...299).contains(httpResponse.statusCode) {
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("DECODING ERROR:", error)
                    throw APIError.decoding(error)
                }
            } else {
                let message = String(data: data, encoding: .utf8) ?? "Server error"
                throw APIError.server(message)
            }
        } catch {
            print("NETWORK ERROR:", error)
            throw APIError.network(error)
        }
    }
}
