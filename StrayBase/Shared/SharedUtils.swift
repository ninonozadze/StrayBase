//
//  SharedUtils.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

struct SharedUtils {}

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
            
            static let notAccountText: String = "Don't have an account?"
            static let signupText: String = "Sign Up"
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
        }
        
        struct ProfileView {
            static let generalSectionTitle: String = "General"
            
            static let versionImageName: String = "gear"
            static let versionTitle: String = "Version"
            
            static let accountSectionTitle: String = "Account"
            
            static let signOutImageName: String = "arrow.left.circle.fill"
            static let signOutTitle: String = "Sign Out"
            
            static let deleteAccountImageName: String = "xmark.circle.fill"
            static let deleteAccountTitle: String = "Delete Account"
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
        
        struct SettingsTabView {
            static let navigationTitle: String = "Settings"
            static let tabItemLabel: String = "Settings"
            static let tabItemImageName: String = "gearshape.fill"
        }
        
    }
    
}
