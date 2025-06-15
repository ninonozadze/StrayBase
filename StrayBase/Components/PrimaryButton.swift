//
//  PrimaryButton.swift
//  StrayBase
//
//  Created by Nino Nozadze on 07.04.25.
//

import SwiftUI

struct PrimaryButton: View {
    
    let viewModel: PrimaryButtonViewModel
    
    var body: some View {
        Button(action: viewModel.action) {
            HStack {
                Text(viewModel.title)
                    .fontWeight(.semibold)
                Image(systemName: viewModel.imageName)
            }
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 32,
                   height: 48)
        }
        .background(Color(.cyan))
        .cornerRadius(10)
        .padding(.top, 24)
        .disabled(!viewModel.isEnabled)
        .opacity(viewModel.isEnabled ? 1 : 0.5)
    }
}

struct PrimaryButtonViewModel {
    let title: String
    let imageName: String
    let isSecondary: Bool = false
    let isEnabled: Bool
    let action: () -> Void
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            viewModel: .init(
                title: "button",
                imageName: "plus",
                isEnabled: true,
                action: {
                    print("PrimaryButton")
                }
            )
        )
    }
}
