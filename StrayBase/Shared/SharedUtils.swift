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
        static let verificationMessageWhenSent = "A verification email has been sent to {1s}. Please check your inbox and click the verification link before proceeding. If you don't see the email, make sure to check your spam or junk folder."
        static let noPendingVerificationMessage = "No pending registration found."
        static let successfulVerificationMessage = "Email verified successfully! Registration completed."
        static let notVerifiedMessage = "Email not verified yet. Please check your inbox and click the verification link. If you don't see the email, make sure to check your spam or junk folder."
        static let failedtoVerifyMessage = "Failed to verify email: {1s}"
        static let resentVerificationMessage = "Verification email resent to {1s}."
        static let failedtoResendVerificationMessage = "Failed to resend verification email: {1s}."
        
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
            static let loginImageName = "pet-care"
            
            static let emailInputTitle = "Email Address"
            static let emailInputPlaceholder = "name@example.com"
            
            static let passwordInputTitle = "Password"
            static let passwordInputPlaceholder = "Enter your password"
            
            static let signInButtonTitle = "SIGN IN"
            static let signInButtonImageName = "arrow.right"
            
            static let forgotPasswordText = "Forgot Password?"
            
            static let notAccountText = "Don't have an account?"
            static let signupText = "Sign Up"
            
            static let loginErrorTitle = "Sign In Failed"
            static let loginErrorButton = "OK"
            static let loginUnknownError = "An unknown error occurred during sign in"
        }
        
        struct RegistrationView {
            static let registrationImageName = "pet-care"
            
            static let emailInputTitle = "Email Address"
            static let emailInputPlaceholder = "name@example.com"
            
            static let fullnameInputTitle = "Full Name"
            static let fullnameInputPlaceholder = "Enter your name"
            
            static let passwordInputTitle = "Password"
            static let passwordInputPlaceholder = "Enter your password"
            
            static let confirmPasswordInputTitle = "Confirm Password"
            static let confirmPasswordInputPlaceholder = "Confirm your password"
            
            static let signUpButtonTitle = "SIGN UP"
            static let signUpButtonImageName = "arrow.right"
            
            static let signInText = "Sign in"
            static let signInDescription = "Already have an account?"
            
            static let passwordCheckmarkIconName = "checkmark.circle.fill"
            static let passwordXmarkIconName = "xmark.circle.fill"
            
            static let registrationErrorTitle = "Registration Error"
            static let registrationErrorButton = "OK"
            static let registrationUnknownError = "Unknown error."
        }
        
        struct ProfileView {
            static let accountSectionTitle = "Account"
            
            static let signOutImageName = "arrow.left.circle.fill"
            static let signOutTitle = "Sign Out"
            
            static let deleteAccountImageName = "xmark.circle.fill"
            static let deleteAccountTitle = "Delete Account"
            
            static let deleteAlertTitle = "Delete Account"
            static let deleteAlertDescription = "Are you sure you want to delete your account?"
            static let deleteAlertButton = "Delete"
            
            static let signOutAlertTitle = "Sign out"
            static let signOutAlertDescription = "Are you sure you want to sign out?"
            static let signOutAlertButton = "Sign out"
        }
        
        struct EmailVerificationView {
            static let verificationMainImageName = "envelope.circle.fill"
            static let verificationMainText = "Verify Your Email"
            
            static let verificationButtonTitle = "I've Verified My Email"
            static let verificationButtonIcon = "checkmark.circle"
            
            static let resendButtonTitle = "Resend Email"
            static let resendButtonIcon = "arrow.clockwise"
            
            static let backButtonTitle = "Back to Registration"
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
            static let resetEmailSentMessage = "A password reset link has been sent to {1s}. Please check your email and follow the instructions to reset your password. If you don't see the email, make sure to check your spam or junk folder."
        }
        
    }
    
}

extension SharedUtils {
    
    enum tab: Hashable {
        case dashboard, shelter, addStray, foster, profile
    }
    
}

extension SharedUtils.tab {
    
    var tabTitle: String {
        switch self {
        case .dashboard:
            return "Home"
        case .shelter:
            return "Shelters"
        case .addStray:
            return "Add Stray"
        case .foster:
            return "Foster"
        case .profile:
            return "Profile"
        }
    }

    var tabImageName: String {
        switch self {
        case .dashboard:
            return "house"
        case .shelter:
            return "mappin.and.ellipse.circle"
        case .addStray:
            return "pawprint"
        case .foster:
            return "heart.text.square"
        case .profile:
            return "person"
        }
    }
    
}

extension SharedUtils {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
