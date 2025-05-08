//
//  VerificationView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 07.05.25.
//

import SwiftUI

struct EmailVerificationView: View {
    @ObservedObject var viewModel: AuthViewModel
    var dismissAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "envelope.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Text("Verify Your Email")
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
                    title: "I've Verified My Email",
                    imageName: "checkmark.circle"
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
                        Text("Resend Email")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.clockwise")
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
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 20)
            }
            
            Spacer()
            
            Button {
                viewModel.resetEmailVerificationState()
            } label: {
                HStack(spacing: 3) {
                    Text("Back to Registration")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .alert("Registration Status", isPresented: .constant(viewModel.isEmailVerified)) {
            Button("Continue") {
                dismissAction()
            }
        } message: {
            Text("Your email has been verified and registration is complete!")
        }
    }
}
