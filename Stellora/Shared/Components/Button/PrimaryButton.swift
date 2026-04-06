//
//  Button.swift
//  Stellora
//
//  Created by Dhruv Aggarwal on 05/04/26.
//

import SwiftUI

struct PrimaryButton: View {
    var action : () -> Void
    var body: some View {
        Button("button", action: action)
    }
}

func action() {
     print("button tapped")
 }


#Preview {
    PrimaryButton(action: action)
}
