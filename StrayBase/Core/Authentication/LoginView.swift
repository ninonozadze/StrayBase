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
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                
                Image(LoginViewConsts.loginImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    InputView(
                        text: $email,
                        title: LoginViewConsts.emailInputTitle,
                        placeholder: LoginViewConsts.emailInputPlaceholder
                    )
                    .autocapitalization(.none)
                    
                    InputView(
                        text: $password,
                        title: LoginViewConsts.passwordInputTitle,
                        placeholder: LoginViewConsts.passwordInputPlaceholder,
                        isSecuredField: true
                    )
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    print("sign in") // TODO: Tmp
                } label: {
                    HStack {
                        Text(LoginViewConsts.signInButtonTitle)
                            .fontWeight(.semibold)
                        Image(systemName: LoginViewConsts.signInButtonImageName)
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,
                           height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text(LoginViewConsts.notAccountText)
                        Text(LoginViewConsts.signupText)
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
