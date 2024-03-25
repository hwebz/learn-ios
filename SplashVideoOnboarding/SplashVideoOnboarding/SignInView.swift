//
//  SignInView.swift
//  SplashVideoOnboarding
//
//  Created by Personal on 25/03/2024.
//

import SwiftUI

struct SignInView: View {
    @State var show = false
    @State var text = ""
    @State var password = ""
    @Binding var showSignView: Bool
    var body: some View {
        VStack {
            if !show {
                Spacer()
            }
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: show ? .infinity : 400)
                    .padding(.horizontal, show ? 0 : 10)
                if !show {
                    VStack(spacing: 20) {
                        TheText
                        Buttons
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        Button {
                            withAnimation {
                                show.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: Circle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Continue with email.").bold().font(.title)
                        Text("Set sail on your next adventure by simply entering your email. Let's discover the world together!")
                        TextField("Email address", text: $text)
                            .textInputAutocapitalization(.never)
                            .padding(.leading)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
                            }
                        PasswordTextField(text: $password)
                        Spacer()
                        ButtonStyle(icon: "", title: "Next") {
                            
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                    .padding(.horizontal)
                }
            }
            .clipped()
        }
        .offset(y: show ? 0 : -30)
        .ignoresSafeArea()
    }
    
    var TheText: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Voyage").font(.largeTitle)
                Spacer()
                Button {
                    withAnimation {
                        showSignView.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
                .background(.ultraThinMaterial, in: Circle())
            }
            Text("Get started").font(.title)
            Text("Embark on unforgettable journeys with Voyage")
                .foregroundStyle(.secondary)
                .bold()
        }
    }
    
    var Buttons: some View {
        VStack(spacing: 10) {
            ButtonStyle(icon: "mail", title: "Continue with Email") {
                withAnimation {
                    show.toggle()
                }
            }
            ButtonStyle(icon: "google", title: "Continue with Gmail") {
                withAnimation {
                    show.toggle()
                }
            }
            ButtonStyle(icon: "apple", title: "Continue with Apple") {
                withAnimation {
                    show.toggle()
                }
            }
        }
    }
}

#Preview {
    SignInView(showSignView: .constant(false))
}
