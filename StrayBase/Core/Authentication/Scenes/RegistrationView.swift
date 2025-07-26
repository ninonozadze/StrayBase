//
//  RegistrationView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 22.03.25.
//

import SwiftUI

private typealias RegistrationViewConsts = SharedUtils.AuthenticationViews.RegistrationView

struct RegistrationView: View {
    
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            if viewModel.isEmailVerificationSent && !viewModel.isEmailVerified {
                EmailVerificationView {
                    dismiss()
                }
            } else {
                RegistrationFormView()
            }
        }
        .onAppear {
            viewModel.resetEmailVerificationState()
        }
    }
    
    @ViewBuilder
    private func RegistrationFormView() -> some View {
        Spacer()
        
        VStack {
            Image(SharedUtils.appIcon)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(
                    text: $email,
                    title: RegistrationViewConsts.emailInputTitle,
                    placeholder: RegistrationViewConsts.emailInputPlaceholder,
                    style: .classic
                )
                .autocapitalization(.none)
                
                InputView(
                    text: $fullname,
                    title: RegistrationViewConsts.fullnameInputTitle,
                    placeholder: RegistrationViewConsts.fullnameInputPlaceholder,
                    style: .classic
                )
                
                InputView(
                    text: $password,
                    title: RegistrationViewConsts.passwordInputTitle,
                    placeholder: RegistrationViewConsts.passwordInputPlaceholder,
                    style: .classic,
                    isSecure: true,
                    showPasswordToggle: true
                )

                
                ZStack(alignment: .trailing) {
                    InputView(
                        text: $confirmPassword,
                        title:RegistrationViewConsts.confirmPasswordInputTitle,
                        placeholder: RegistrationViewConsts.confirmPasswordInputPlaceholder,
                        style: .classic,
                        isSecure: true
                    )

                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: RegistrationViewConsts.passwordCheckmarkIconName)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                                
                        } else {
                            Image(systemName: RegistrationViewConsts.passwordXmarkIconName)
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            PrimaryButton(
                viewModel: .init(
                    title: RegistrationViewConsts.signUpButtonTitle,
                    imageName: RegistrationViewConsts.signUpButtonImageName,
                    isEnabled: formIsValid && !viewModel.isLoading,
                    action: {
                        Task {
                            do {
                                try await viewModel.createUser(
                                    withEmail: email,
                                    password: password,
                                    fullname: fullname
                                )
                            } catch {
                                showErrorAlert = true
                            }
                        }
                    }
                )
            )
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 10)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text(RegistrationViewConsts.signInDescription)
                        .foregroundColor(.cyan)
                    Text(RegistrationViewConsts.signInText)
                        .fontWeight(.bold)
                        .foregroundColor(.cyan)
                }
                .font(.system(size: 14))
            }
        }
        .alert(RegistrationViewConsts.registrationErrorTitle,
               isPresented: $showErrorAlert) {
            Button(RegistrationViewConsts.registrationErrorButton,
                   role: .cancel) {}
        } message: {
            Text(viewModel.verificationMessage ?? RegistrationViewConsts.registrationUnknownError)
        }
        
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && isValidEmail(email)
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
