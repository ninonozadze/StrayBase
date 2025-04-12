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
    
    var body: some View {
        
        NavigationStack {
            
            Spacer()
            
            VStack {
                Image(RegistrationViewConsts.registrationImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    InputView(
                        text: $email,
                        title: RegistrationViewConsts.emailInputTitle,
                        placeholder: RegistrationViewConsts.emailInputPlaceholder
                    )
                    .autocapitalization(.none)
                    
                    InputView(
                        text: $fullname,
                        title: RegistrationViewConsts.fullnameInputTitle,
                        placeholder: RegistrationViewConsts.fullnameInputPlaceholder
                    )
                    
                    InputView(
                        text: $password,
                        title: RegistrationViewConsts.passwordInputTitle,
                        placeholder: RegistrationViewConsts.passwordInputPlaceholder,
                        isSecuredField: true
                    )
                    
                    InputView(
                        text: $confirmPassword,
                        title: RegistrationViewConsts.confirmPasswordInputTitle,
                        placeholder: RegistrationViewConsts.confirmPasswordInputPlaceholder,
                        isSecuredField: true
                    )
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                PrimaryButton(
                    title: RegistrationViewConsts.signUpButtonTitle,
                    imageName: RegistrationViewConsts.signUpButtonImageName
                ) {
                    Task {
                        try await viewModel.createUser(
                            withEmail: email,
                            password: password,
                            fullname: fullname
                        )
                    }
                }
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text(RegistrationViewConsts.signInDescription)
                        Text(RegistrationViewConsts.signInText)
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
