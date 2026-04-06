//
//  AllTextField.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 05/04/26.
//

import SwiftUI

struct AppTextField: View {
    var title: String = ""
    var placeholder: String = ""
    @Binding var text: String
    var errorMessage: String?
    var capitalization: TextInputAutocapitalization?
    var autoCorrectionEnabled: Bool = true
    
    var validError : Bool {
        guard let error = errorMessage else { return false }
        let trimmed = error.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            if !title.isEmpty{
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(validError ? Color.red : Color.primary)
            }
            TextField(placeholder, text: $text)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(validError ? .red : Color.gray.opacity(0.2), lineWidth: 1)
                )
                .cornerRadius(10)
                .textInputAutocapitalization(capitalization ?? .sentences)
                .autocorrectionDisabled(autoCorrectionEnabled)
            if let errorMessage, validError {
                Text(errorMessage.capitalized)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            
        }
        
    }
}

#Preview {
    @Previewable @State var text: String = "value"
    
    VStack {
        AppTextField(
            title: "Title",
            placeholder: "Placeholder",
            text: $text,
            errorMessage: "error message"
        )
        AppTextField(
            title: "Title",
            placeholder: "Placeholder",
            text: $text,
            errorMessage: ""
        )
        AppTextField(
            title: "Title",
            placeholder: "Placeholder",
            text: $text,
            errorMessage: nil,
        )
    }
    
}
