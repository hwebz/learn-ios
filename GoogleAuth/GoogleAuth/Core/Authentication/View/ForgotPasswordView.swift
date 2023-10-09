//
//  ForgotPasswordView.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // Form Fields
                InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(.none)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Send Reset Link Button
                AuthButton(title: "SEND RESET LINK") {
                    Task {
                        try await viewModel.forgotPassword(withEmail: email) {
                            dismiss()
                        }
                    }
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                .padding(.top, 24)
                
                Spacer()
                
                // Sign Up Button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
                Spacer()
                
                // Back to login button
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.left")
                        Text("Back to login")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
    }
}

extension ForgotPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(AuthViewModel())
    }
}
