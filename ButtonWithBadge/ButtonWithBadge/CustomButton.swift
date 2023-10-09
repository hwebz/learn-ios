//
//  CustomButton.swift
//  ButtonWithBadge
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct CustomButton: View {
    
    @State var count = 0
    let color: Color
    let foregroundColor: Color
    let badgeColor: Color
    
    var body: some View {
        ZStack {
            Button(action: {
                print("clicked")
                self.count += 1
            }) {
                Image(systemName: "bell.fill").resizable().frame(width: 40, height: 40)
            }
            .padding()
            .background(color)
            .foregroundColor(foregroundColor)
            .clipShape(Circle())
            
            if count != 0 {
                Text("\(count)")
                    .padding(6)
                    .background(badgeColor)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .offset(x: 25, y: -25)
            }
        }
        .animation(.easeInOut, value: count)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(color: .green, foregroundColor: .white, badgeColor: .black)
    }
}
