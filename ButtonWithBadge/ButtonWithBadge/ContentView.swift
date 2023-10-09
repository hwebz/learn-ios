//
//  ContentView.swift
//  ButtonWithBadge
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Badge Buttons")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
            HStack {
                CustomButton(color: .green, foregroundColor: .white, badgeColor: .red)
                CustomButton(color: .blue, foregroundColor: .white, badgeColor: .green)
                CustomButton(color: .gray, foregroundColor: .white, badgeColor: .blue)
                CustomButton(color: .yellow, foregroundColor: .white, badgeColor: .gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
