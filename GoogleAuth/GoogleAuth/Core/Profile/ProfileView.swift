//
//  ProfileView.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                            // Because it's in email format, Apple automaticaly detect and highlight that using default accent color (blue)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section("General") {
                    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray), description: "1.0.0")
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                    }
                    
                    Button {
                        print("Deleting account...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color(.red))
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
