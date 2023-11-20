//
//  RegistrationView.swift
//  ThreadsClone
//
//  Created by Personal on 21/11/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image("threads_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email", text: $email)
                    .modifier(ThreadsTextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your fullname", text: $fullname)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .modifier(ThreadsTextFieldModifier())
            }
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .modifier(ThreadsButtonModifier())
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .foregroundColor(.black)
            .padding(.vertical, 16)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
