//
//  AuthViewModel.swift
//  StrayBase
//
//  Created by Nino Nozadze on 12.04.25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

private typealias AuthenticationConsts = SharedUtils.Authentication

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isEmailVerificationSent = false
    @Published var isEmailVerified = false
    @Published var verificationMessage: String?
    @Published var isLoading = false
    
    private var pendingUserData: (email: String, password: String, fullname: String)?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String,
                password: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password
            )
            
            try await result.user.reload()
            
            if !result.user.isEmailVerified {
                try Auth.auth().signOut()
                
                throw NSError(
                    domain: "AuthError",
                    code: AuthErrorCode.userNotFound.rawValue,
                    userInfo: [NSLocalizedDescriptionKey: AuthenticationConsts.emailNotVerifiedError]
                )
            }
            
            self.userSession = result.user
            await fetchUser()
            
        } catch {
            print("DEBUG: Failed to sign in with error - \(error.localizedDescription)")
            throw handleAuthError(error)
        }
    }
    
    private func handleAuthError(_ error: Error) -> Error {
        guard let authError = error as NSError? else {
            return NSError(
                domain: "AuthError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: AuthenticationConsts.loginUnknownError]
            )
        }
        
        let errorMessage: String
        
        if authError.domain == "AuthError"
            && authError.localizedDescription == AuthenticationConsts.emailNotVerifiedError {
            return authError
        }
        
        switch AuthErrorCode.Code(rawValue: authError.code) {
        case .invalidEmail:
            errorMessage = AuthenticationConsts.invalidEmailError
            
        case .userDisabled:
            errorMessage = AuthenticationConsts.userDisabledError
            
        case .tooManyRequests:
            errorMessage = AuthenticationConsts.tooManyRequestsError
            
        case .networkError:
            errorMessage = AuthenticationConsts.networkError
            
        case .invalidCredential:
            errorMessage = AuthenticationConsts.invalidCredentialError
            
        case .userTokenExpired:
            errorMessage = AuthenticationConsts.tokenExpiredError
            
        case .requiresRecentLogin:
            errorMessage = AuthenticationConsts.requiresRecentLoginError
            
        default:
            errorMessage = AuthenticationConsts.loginUnknownError.replacingOccurrences(
                of: "{1s}",
                with: authError.localizedDescription
            )
        }
        
        return NSError(
            domain: "AuthError",
            code: authError.code,
            userInfo: [NSLocalizedDescriptionKey: errorMessage]
        )
    }
    
    func createUser(withEmail email: String,
                    password: String,
                    fullname: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password
            )
            
            pendingUserData = (email: email, password: password, fullname: fullname)
            
            try await result.user.sendEmailVerification()
            
            try Auth.auth().signOut()
            
            isEmailVerificationSent = true
            verificationMessage = AuthenticationConsts.verificationMessageWhenSent
                .replacingOccurrences(of: "{1s}",
                                      with: email)
            
        } catch {
            print("DEBUG: Failed to create user with error - \(error.localizedDescription)")
            verificationMessage = error.localizedDescription
            throw error
        }

    }
    
    func checkEmailVerificationAndCompleteRegistration() async throws {
        guard let pendingData = pendingUserData else {
            verificationMessage = AuthenticationConsts.noPendingVerificationMessage
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await Auth.auth().signIn(
                withEmail: pendingData.email,
                password: pendingData.password
            )
            
            try await result.user.reload()
            
            if result.user.isEmailVerified {
                let user = User(
                    id: result.user.uid,
                    fullname: pendingData.fullname,
                    email: pendingData.email
                )
                
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                
                self.userSession = result.user
                await fetchUser()
                
                isEmailVerified = true
                verificationMessage = AuthenticationConsts.successfulVerificationMessage
                pendingUserData = nil
                
            } else {
                try Auth.auth().signOut()
                verificationMessage = AuthenticationConsts.notVerifiedMessage
            }
            
        } catch {
            print("DEBUG: Failed to verify email with error - \(error.localizedDescription)")
            verificationMessage = AuthenticationConsts.failedtoVerifyMessage
                .replacingOccurrences(of: "{1s}",
                                      with: error.localizedDescription)
            throw error
        }
        
    }
    
    func resendVerificationEmail() async throws {
        guard let pendingData = pendingUserData else {
            verificationMessage = AuthenticationConsts.noPendingVerificationMessage
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await Auth.auth().signIn(
                withEmail: pendingData.email,
                password: pendingData.password
            )
            
            try await result.user.sendEmailVerification()
            try Auth.auth().signOut()
            
            verificationMessage = AuthenticationConsts.resentVerificationMessage
                .replacingOccurrences(of: "{1s}",
                                      with: pendingData.email)
            
        } catch {
            print("DEBUG: Failed to resend verification email with error - \(error.localizedDescription)")
            verificationMessage = AuthenticationConsts.failedtoResendVerificationMessage
                .replacingOccurrences(of: "{1s}",
                                      with: error.localizedDescription)
            throw error
        }
        
    }
    
    func resetEmailVerificationState() {
        isEmailVerificationSent = false
        isEmailVerified = false
        verificationMessage = nil
        pendingUserData = nil
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            resetEmailVerificationState()
            
        } catch {
            print("DEBUG: Failed to sign out user with error - \(error.localizedDescription)")
            throw error
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No current user to delete")
            return
        }
        
        let uid = user.uid
        
        do {
            try await Firestore.firestore().collection("users").document(uid).delete()
            try await user.delete()
            self.userSession = nil
            self.currentUser = nil
            resetEmailVerificationState()
            
        } catch {
            print("DEBUG: Failed to delete account with error - \(error.localizedDescription)")
            throw error
        }
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
    
    func sendPasswordResetEmail(withEmail email: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection("users")
                .whereField("email", isEqualTo: email)
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                throw NSError(
                    domain: "AuthError",
                    code: AuthErrorCode.userNotFound.rawValue,
                    userInfo: [NSLocalizedDescriptionKey: AuthenticationConsts.userNotFoundError]
                )
            }
            
            try await Auth.auth().sendPasswordReset(withEmail: email)
            
        } catch let firestoreError {
            print("DEBUG: Failed to check email or send password reset with error - \(firestoreError.localizedDescription)")
            
            if let nsError = firestoreError as NSError?, nsError.domain == "AuthError" {
                throw firestoreError
            }
            
            throw handlePasswordResetError(firestoreError)
        }
    }

    private func handlePasswordResetError(_ error: Error) -> Error {
        guard let authError = error as NSError? else {
            return NSError(
                domain: "AuthError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: AuthenticationConsts.resetPasswordUnknownError]
            )
        }
        
        let errorMessage: String
        
        switch AuthErrorCode.Code(rawValue: authError.code) {
        case .invalidEmail:
            errorMessage = AuthenticationConsts.invalidEmailError
            
        case .userNotFound:
            errorMessage = AuthenticationConsts.userNotFoundError
            
        case .tooManyRequests:
            errorMessage = AuthenticationConsts.tooManyRequestsError
            
        case .networkError:
            errorMessage = AuthenticationConsts.networkError
            
        default:
            errorMessage = AuthenticationConsts.resetPasswordUnknownError.replacingOccurrences(
                of: "{1s}",
                with: authError.localizedDescription
            )
        }
        
        return NSError(
            domain: "AuthError",
            code: authError.code,
            userInfo: [NSLocalizedDescriptionKey: errorMessage]
        )
    }
}
