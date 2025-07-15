//
//  ActionRowButton.swift
//  StrayBase
//
//  Created by Nino Nozadze on 15.07.25.
//

import SwiftUI

struct ActionRowButton: View {
    var action: () -> Void
    var leadingImage: String
    var title: String
    var subtitle: String
    var trailingImage: String = "chevron.right"
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: leadingImage)
                        .font(.title2)
                        .foregroundColor(.orange)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: trailingImage)
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 8)
        }
        .listRowBackground(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
}
