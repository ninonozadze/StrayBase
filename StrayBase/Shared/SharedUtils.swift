//
//  SharedUtils.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

struct SharedUtils {}

extension SharedUtils {
    
    struct Authentication {
        static let verificationMessageWhenSent: String = "A verification email has been sent to {1s}. Please check your inbox and click the verification link before proceeding."
        static let noPendingVerificationMessage: String = "No pending registration found."
        static let successfulVerificationMessage: String = "Email verified successfully! Registration completed."
        static let notVerifiedMessage: String = "Email not verified yet. Please check your inbox and click the verification link."
        static let failedtoVerifyMessage: String = "Failed to verify email: {1s}"
        static let resentVerificationMessage: String = "Verification email resent to {1s}."
        static let failedtoResendVerificationMessage: String = "Failed to resend verification email: {1s}."
        
        static let invalidEmailError = "Please enter a valid email address."
        static let userDisabledError = "This account has been disabled. Please contact support."
        static let tooManyRequestsError = "Too many failed attempts. Please try again later."
        static let networkError = "Network error. Please check your internet connection and try again."
        static let invalidCredentialError = "Invalid email or password. Please check your credentials and try again."
        static let tokenExpiredError = "Your session has expired. Please try signing in again."
        static let requiresRecentLoginError = "This operation requires recent authentication. Please sign in again."
        static let loginUnknownError = "An unknown error occurred: {1s}"
        
        static let userNotFoundError = "No account found with this email address. Please check your email and try again."
        static let resetPasswordUnknownError = "Failed to send password reset email. Please try again later. Error: {1s}"
        
        static let emailNotVerifiedError = "Please verify your email address before signing in. Check your inbox for the verification link."
    }
    
}

extension SharedUtils {
    
    struct AuthenticationViews {
        
        struct LoginView {
            static let loginImageName: String = "pet-care"
            
            static let emailInputTitle: String = "Email Address"
            static let emailInputPlaceholder: String = "name@example.com"
            
            static let passwordInputTitle: String = "Password"
            static let passwordInputPlaceholder: String = "Enter your password"
            
            static let signInButtonTitle: String = "SIGN IN"
            static let signInButtonImageName: String = "arrow.right"
            
            static let forgotPasswordText: String = "Forgot Password?"
            
            static let notAccountText: String = "Don't have an account?"
            static let signupText: String = "Sign Up"
            
            static let loginErrorTitle = "Sign In Failed"
            static let loginErrorButton = "OK"
            static let loginUnknownError = "An unknown error occurred during sign in"
        }
        
        struct RegistrationView {
            static let registrationImageName: String = "pet-care"
            
            static let emailInputTitle: String = "Email Address"
            static let emailInputPlaceholder: String = "name@example.com"
            
            static let fullnameInputTitle: String = "Full Name"
            static let fullnameInputPlaceholder: String = "Enter your name"
            
            static let passwordInputTitle: String = "Password"
            static let passwordInputPlaceholder: String = "Enter your password"
            
            static let confirmPasswordInputTitle: String = "Confirm Password"
            static let confirmPasswordInputPlaceholder: String = "Confirm your password"
            
            static let signUpButtonTitle: String = "SIGN UP"
            static let signUpButtonImageName: String = "arrow.right"
            
            static let signInText: String = "Sign in"
            static let signInDescription: String = "Already have an account?"
            
            static let passwordCheckmarkIconName: String = "checkmark.circle.fill"
            static let passwordXmarkIconName: String = "xmark.circle.fill"
            
            static let registrationErrorTitle: String = "Registration Error"
            static let registrationErrorButton: String = "OK"
            static let registrationUnknownError: String = "Unknown error."
        }
        
        struct ProfileView {
            static let accountSectionTitle: String = "Account"
            
            static let signOutImageName: String = "arrow.left.circle.fill"
            static let signOutTitle: String = "Sign Out"
            
            static let deleteAccountImageName: String = "xmark.circle.fill"
            static let deleteAccountTitle: String = "Delete Account"
            
            static let deleteAlertTitle: String = "Delete Account"
            static let deleteAlertDescription: String = "Are you sure you want to delete your account?"
            static let deleteAlertButton: String = "Delete"
            
            static let signOutAlertTitle: String = "Sign out"
            static let signOutAlertDescription: String = "Are you sure you want to sign out?"
            static let signOutAlertButton: String = "Sign out"
        }
        
        struct EmailVerificationView {
            static let verificationMainImageName: String = "envelope.circle.fill"
            static let verificationMainText: String = "Verify Your Email"
            
            static let verificationButtonTitle: String = "I've Verified My Email"
            static let verificationButtonIcon: String = "checkmark.circle"
            
            static let resendButtonTitle: String = "Resend Email"
            static let resendButtonIcon: String = "arrow.clockwise"
            
            static let alertRegistrationStatus: String = "Registration Status"
            static let alertRegistrationButton: String = "Continue"
            static let alertRegistrationMessage: String = "Your email has been verified and registration is complete!"
        }
        
        struct ForgotPasswordView {
            static let forgotPasswordImageName = "lock.shield"
            
            static let forgotPasswordTitle = "Reset Password"
            static let forgotPasswordDescription = "Enter your email address and we'll send you a link to reset your password."
            
            static let emailInputTitle = "Email Address"
            static let emailInputPlaceholder = "name@example.com"
            
            static let sendResetEmailButtonTitle = "Send Reset Email"
            static let sendResetEmailButtonImageName = "envelope"
            
            static let backToLoginDescription = "Remember your password?"
            static let backToLoginText = "Sign In"
            
            static let resetPasswordErrorTitle = "Reset Password Failed"
            static let resetPasswordErrorButton = "OK"
            static let resetPasswordUnknownError = "An unknown error occurred. Please try again."
            
            static let resetPasswordSuccessTitle = "Email Sent"
            static let resetPasswordSuccessButton = "OK"
            static let resetEmailSentMessage = "A password reset link has been sent to {1s}. Please check your email and follow the instructions to reset your password."
        }
        
    }
    
}

extension SharedUtils {
    
    struct TabViews {
        
        struct DashboardTabView {
            static let navigationTitle: String = "Home"
            static let tabItemLabel: String = "Home"
            static let tabItemImageName: String = "house.fill"
        }
        
        struct ProfileTabView {
            static let navigationTitle: String = "Profile"
            static let tabItemLabel: String = "Profile"
            static let tabItemImageName: String = "person.crop.circle.fill"
        }
        
    }
    
}
