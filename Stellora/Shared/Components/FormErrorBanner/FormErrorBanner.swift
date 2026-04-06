//
//  FormErrorBanner.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 06/04/26.
//

import SwiftUI


struct FormErrorBanner: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.red)
                .padding(.top, 1)

            Text(message)
                .font(.footnote)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)
        }
        .padding(12)
        .background(Color.red.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red.opacity(0.18), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    FormErrorBanner(message: "Email already registered")
        .padding()
}
