//
//  InfoRow.swift
//  StrayBase
//
//  Created by Nino Nozadze on 03.07.25.
//

import SwiftUI

struct InfoRow: View {
    let icon: String
    let iconColor: Color
    let text: String
    let textColor: Color
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 16)
            Text(text)
                .font(.subheadline)
                .foregroundColor(textColor)
                .lineLimit(2)
            Spacer()
        }
    }
}
