//
//  PasswordTextField.swift
//  SplashVideoOnboarding
//
//  Created by Personal on 25/03/2024.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var text: String
    @State var progress: CGFloat = 0
    @State var checkMinChars = false
    @State var checkLetter = false
    @State var checkPunctuation = false
    @State var checkNumber = false
    @State var showPassword = false
    
    var progressColor: Color {
        // Check if the text contains any letters (both uppercase and lowercase)
        let containsLetters = text.rangeOfCharacter(from: .letters) != nil
        // Check if the text contains any numbers (decimal digits).
        let containsNumbers = text.rangeOfCharacter(from: .decimalDigits) != nil
        // Check if the text contains any of the special characters from the given set "!@#$%*^&".
        let containsPunctuation = text.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%*^&")) != nil
        // Check and determine the color based on the conditions:
        // 1. If the text contains letters, numbers, special characters and has 8 or more characters.
        if containsLetters && containsNumbers && containsPunctuation && text.count >= 8 {
            return Color.green
        // 2. If the text contains only letters (and does not contain numbers or special characters)
        } else if containsLetters && !containsNumbers && !containsPunctuation {
            return Color.red
        // 3. If the text contains only numbers (and does not contain letters or special characters)
        } else if containsNumbers && !containsLetters && !containsPunctuation {
            return Color.red
        // 4. If the text contains both letters and numbers but not the special characters.
        } else if containsLetters && containsNumbers && !containsPunctuation {
            return Color.yellow
        // 5. If the text contains letters, numbers, and special characters (but less than 8 characters in total)
        } else if containsLetters && containsNumbers && containsPunctuation {
            return Color.blue
        // 6. Default color if none of the above conditions are met.
        } else {
            return Color.gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            ZStack {
                if !showPassword {
                    SecureField("Password", text: $text)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
                        .onChange(of: text, { oldValue, newValue in
                            withAnimation {
                                progress = min(1.0, max(0, CGFloat(newValue.count) / 8.0))
                                checkMinChars = newValue.count >= 8
                                checkLetter = newValue.rangeOfCharacter(from: .letters) != nil
                                checkNumber = newValue.rangeOfCharacter(from: .decimalDigits) != nil
                                checkPunctuation = newValue.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%*^&")) != nil
                            }
                        })
                        .padding(.trailing, 50)
                        .frame(height: 60)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
                        }
                } else {
                    TextField("Password", text: $text)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
                        .onChange(of: text, { oldValue, newValue in
                            withAnimation {
                                progress = min(1.0, max(0, CGFloat(newValue.count) / 8.0))
                                checkMinChars = newValue.count >= 8
                                checkLetter = newValue.rangeOfCharacter(from: .letters) != nil
                                checkNumber = newValue.rangeOfCharacter(from: .decimalDigits) != nil
                                checkPunctuation = newValue.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%*^&")) != nil
                            }
                        })
                        .padding(.trailing, 50)
                        .frame(height: 60)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
                        }
                }
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: 0, to: progress)
                    .stroke(progressColor, lineWidth: 3)
                    .frame(height: 60)
                    .rotationEffect(.degrees(-180))
            }
            .overlay(alignment: .trailing) {
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .padding(.trailing, 10)
                    .onTapGesture {
                        showPassword.toggle()
                    }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                CheckText(text: "Minimum 8 characters", check: $checkMinChars)
                CheckText(text: "At least one letter", check: $checkLetter)
                CheckText(text: "(!@#$%*^&)", check: $checkPunctuation)
                CheckText(text: "Number", check: $checkNumber)
            }
        }
    }
}

struct CheckText: View {
    let text: String
    @Binding var check: Bool
    var body: some View {
        HStack {
            Image(systemName: check ? "checkmark.circle.fill" : "circle")
            Text(text)
        }
        .foregroundColor(check ? .green : .gray)
    }
}

#Preview {
    PasswordTextField(text: .constant(""))
}
