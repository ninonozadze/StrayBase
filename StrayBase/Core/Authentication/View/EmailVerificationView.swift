//
//  VerificationView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 07.05.25.
//

import SwiftUI

private typealias VerificationViewConsts = SharedUtils.AuthenticationViews.EmailVerificationView

struct EmailVerificationView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var dismissAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: VerificationViewConsts.verificationMainImageName)
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Text(VerificationViewConsts.verificationMainText)
                .font(.title2)
                .fontWeight(.bold)
            
            if let message = viewModel.verificationMessage {
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 16) {
                PrimaryButton(
                    title: VerificationViewConsts.verificationButtonTitle,
                    imageName: VerificationViewConsts.verificationButtonIcon
                ) {
                    Task {
                        try await viewModel.checkEmailVerificationAndCompleteRegistration()
                    }
                }
                .disabled(viewModel.isLoading)
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
                
                Button(action: {
                    Task {
                        try await viewModel.resendVerificationEmail()
                    }
                }) {
                    HStack {
                        Text(VerificationViewConsts.resendButtonTitle)
                            .fontWeight(.semibold)
                        Image(systemName: VerificationViewConsts.resendButtonIcon)
                    }
                    .foregroundColor(.blue)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                .disabled(viewModel.isLoading)
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
            }
            .padding(.top, 30)
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Color.clear
                        .frame(height: 20)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button {
                viewModel.resetEmailVerificationState()
            } label: {
                HStack(spacing: 3) {
                    Text(VerificationViewConsts.backButtonTitle)
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
    }
}
