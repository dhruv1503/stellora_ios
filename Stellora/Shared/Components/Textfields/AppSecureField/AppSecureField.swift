//
//  AppSecureField.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 05/04/26.
//

import SwiftUI

struct AppSecureField: View {
    var title: String = ""
    var placeholder: String = "Enter your password"
    
    @Binding var text: String
    var errorMessage: String?
    
    @State private var showPassword: Bool = false
    
    var validError: Bool {
        guard let error = errorMessage else { return false }
        return !error.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if !title.isEmpty {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(validError ? .red : .primary)
            }
            
            HStack(spacing: 8) {
                Group {
                    if showPassword {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundStyle(.fill)
                }
            }
            .padding(12)
            .background(Color(.secondarySystemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(validError ? .red : .gray.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(10)
            
            if let errorMessage, validError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    @Previewable @State var text: String = "Password123"
    
    return AppSecureField(
        title: "Password",
        placeholder: "Enter password",
        text: $text,
        errorMessage: "Password must be at least 8 characters"
    )
    .padding()
}
