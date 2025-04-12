//
//  AuthViewModel.swift
//  StrayBase
//
//  Created by Nino Nozadze on 12.04.25.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String,
                password: String) async throws {
        
    }
    
    func createUser(withEmail email: String,
                    password: String,
                    fullname: String) async throws {
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
