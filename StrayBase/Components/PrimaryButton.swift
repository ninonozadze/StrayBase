//
//  PrimaryButton.swift
//  StrayBase
//
//  Created by Nino Nozadze on 07.04.25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                Image(systemName: imageName)
            }
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 32,
                   height: 48)
        }
        .background(Color(.cyan))
        .cornerRadius(10)
        .padding(.top, 24)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            title: "button",
            imageName: "plus"
        ) {
            print("PrimaryButton")
        }
    }
}
