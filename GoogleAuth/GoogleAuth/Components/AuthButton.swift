//
//  AuthButton.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct AuthButton: View {
    let title: String
    var icon: String = "arrow.right"
    var action: () -> ()
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                Image(systemName: icon)
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(title: "TEST BUTTON") {
            print("TEST")
        }
    }
}
