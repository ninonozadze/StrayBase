//
//  LoginView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 22.03.25.
//

import SwiftUI

private typealias LoginViewConsts = SharedUtils.AuthenticationViews.LoginView

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showErrorAlert = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                
                Image(SharedUtils.appIcon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    InputView(
                        text: $email,
                        title: LoginViewConsts.emailInputTitle,
                        placeholder: LoginViewConsts.emailInputPlaceholder,
                        style: .classic
                    )
                    .autocapitalization(.none)
                    
                    InputView(
                        text:  $password,
                        title: LoginViewConsts.passwordInputTitle,
                        placeholder: LoginViewConsts.passwordInputPlaceholder,
                        style: .classic,
                        isSecure: true,
                        showPasswordToggle: true
                    )
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                PrimaryButton(
                    viewModel: .init(
                        title: LoginViewConsts.signInButtonTitle,
                        imageName: LoginViewConsts.signInButtonImageName,
                        isEnabled: formIsValid && !viewModel.isLoading,
                        action: {
                            Task {
                                do {
                                    try await viewModel.signIn(
                                        withEmail: email,
                                        password: password
                                    )
                                } catch {
                                    errorMessage = error.localizedDescription
                                    showErrorAlert = true
                                }
                            }
                        }
                    )
                )
                
                NavigationLink {
                    ForgotPasswordView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text(LoginViewConsts.forgotPasswordText)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                            .foregroundColor(.cyan)
                }
                .padding(.top, 12)

                ProgressView()
                    .padding(.top, 10)
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text(LoginViewConsts.notAccountText)
                            .foregroundColor(.cyan)
                        Text(LoginViewConsts.signupText)
                            .fontWeight(.bold)
                            .foregroundColor(.cyan)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
        .alert(LoginViewConsts.loginErrorTitle,
               isPresented: $showErrorAlert) {
            Button(LoginViewConsts.loginErrorButton,
                   role: .cancel) {}
        } message: {
            Text(errorMessage.isEmpty
                 ? (LoginViewConsts.loginUnknownError)
                 : errorMessage)
        }
        
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && isValidEmail(email)
        && !password.isEmpty
        && password.count > 5
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = #"^\S+@\S+\.\S+$"#
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
