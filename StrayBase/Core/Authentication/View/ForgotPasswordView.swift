//
//  ForgotPasswordView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 03.06.25.
//

import SwiftUI

private typealias ForgotPasswordViewConsts = SharedUtils.AuthenticationViews.ForgotPasswordView

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showErrorAlert = false
    @State private var showSuccessAlert = false
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: ForgotPasswordViewConsts.forgotPasswordImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 100)
                    .foregroundColor(.blue)
                    .padding(.vertical, 32)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(ForgotPasswordViewConsts.forgotPasswordTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text(ForgotPasswordViewConsts.forgotPasswordDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                VStack(spacing: 24) {
                    InputView(
                        text: $email,
                        viewModel: .init(
                            title: ForgotPasswordViewConsts.emailInputTitle,
                            placeholder: ForgotPasswordViewConsts.emailInputPlaceholder
                        )
                    )
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                PrimaryButton(
                    title: ForgotPasswordViewConsts.sendResetEmailButtonTitle,
                    imageName: ForgotPasswordViewConsts.sendResetEmailButtonImageName
                ) {
                    Task {
                        do {
                            try await viewModel.sendPasswordResetEmail(withEmail: email)
                            successMessage = ForgotPasswordViewConsts.resetEmailSentMessage
                                .replacingOccurrences(of: "{1s}", with: email)
                            showSuccessAlert = true
                        } catch {
                            errorMessage = error.localizedDescription
                            showErrorAlert = true
                        }
                    }
                }
                .disabled(!formIsValid || viewModel.isLoading)
                .opacity((formIsValid && !viewModel.isLoading) ? 1 : 0.5)
                
                ProgressView()
                    .padding(.top, 10)
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text(ForgotPasswordViewConsts.backToLoginDescription)
                        Text(ForgotPasswordViewConsts.backToLoginText)
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .alert(ForgotPasswordViewConsts.resetPasswordErrorTitle,
               isPresented: $showErrorAlert) {
            Button(ForgotPasswordViewConsts.resetPasswordErrorButton,
                   role: .cancel) {}
        } message: {
            Text(errorMessage.isEmpty
                 ? ForgotPasswordViewConsts.resetPasswordUnknownError
                 : errorMessage)
        }
        .alert(ForgotPasswordViewConsts.resetPasswordSuccessTitle,
               isPresented: $showSuccessAlert) {
            Button(ForgotPasswordViewConsts.resetPasswordSuccessButton) {
                dismiss()
            }
        } message: {
            Text(successMessage)
        }
    }
}

extension ForgotPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
