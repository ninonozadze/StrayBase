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
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    
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
                        text: $fullName,
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
                
                Button {
                    print("sign up") // TODO: Tmp
                } label: {
                    HStack {
                        Text(RegistrationViewConsts.signUpButtonTitle)
                            .fontWeight(.semibold)
                        Image(systemName: RegistrationViewConsts.signUpButtonImageName)
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,
                           height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
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
