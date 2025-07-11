//
//  ConfirmActionButton.swift
//  StrayBase
//
//  Created by Nino Nozadze on 20.05.25.
//

import SwiftUI

struct ConfirmActionButton: View {
    let viewModel: ConfirmActionButtonViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button {
            showAlert = true
        } label: {
            SettingsRowView(
                imageName: viewModel.imageName,
                title: viewModel.title,
                tintColor: viewModel.tintColor
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                primaryButton: .destructive(Text(viewModel.alertConfirmButtonTitle)) {
                    Task {
                        await viewModel.action()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct ConfirmActionButtonViewModel {
    let imageName: String
    let title: String
    let tintColor: Color
    let alertTitle: String
    let alertMessage: String
    let alertConfirmButtonTitle: String
    let action: () async -> Void
}

struct ConfirmActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmActionButton(
            viewModel: .init(
                imageName: "checkmark",
                title: "Confirm",
                tintColor: .gray,
                alertTitle: "title",
                alertMessage: "message",
                alertConfirmButtonTitle: "Confirm",
                action: {}
            )
        )
    }
}
