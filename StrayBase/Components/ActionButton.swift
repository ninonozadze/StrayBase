//
//  ActionButton.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.07.25.
//

import SwiftUI

struct ActionButton: View {
    let action: () -> Void
    let imageName: String
    let text: String
    let backgroundColor: Color

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                Text(text)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(backgroundColor.opacity(0.1))
            .foregroundColor(backgroundColor)
            .cornerRadius(8)
        }
    }
}
