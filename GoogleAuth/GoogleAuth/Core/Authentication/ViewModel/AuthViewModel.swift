//
//  AuthViewModel.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var alertItem: AlertItem?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            // sign user in
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            // fetch the user right after to update UI
            await fetchUser()
        } catch {
            self.alertItem = AlertContext.generateAlert(title: "Log In Error", message: error.localizedDescription)
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            // Sign up a user
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Create a user based on result returned from Firebase Auth
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            // Encode user and then store it in Firestore
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            // fetch the user right after to update UI
            await fetchUser()
        } catch {
            self.alertItem = AlertContext.generateAlert(title: "Sign Up Error", message: error.localizedDescription)
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            // signs out user on backend
            try Auth.auth().signOut()
            // wipes out user session and takes us back to login screen
            self.userSession = nil
            self.currentUser = nil
        } catch {
            self.alertItem = AlertContext.generateAlert(title: "Sign Out Error", message: error.localizedDescription)
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        guard let userSession = self.userSession else { return }
        // delete current user account
        userSession.delete()
        // delete user from Firestore also
        Firestore.firestore().collection("users").document(userSession.uid).delete()
        self.alertItem = AlertContext.generateAlert(title: "Delete Account", message: "Delete Account Successfully", action: {
            self.signOut()
        })
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is ", self.currentUser ?? "<none>")
    }
    
    func forgotPassword(withEmail email: String, action: (() -> Void)? = {}) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            self.alertItem = AlertContext.generateAlert(title: "Password Reset", message: "An email includes a link to reset your password has been sent to your email. Please check it out", action: action)
        } catch {
            self.alertItem = AlertContext.generateAlert(title: "Password Reset Error", message: error.localizedDescription)
            print("DEBUG: Failed to reset password with error \(error.localizedDescription)")
        }
    }
}
