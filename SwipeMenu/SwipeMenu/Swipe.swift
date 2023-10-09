//
//  Swipe.swift
//  SwipeMenu
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct Swipe: View {
    // increase size until meet expectation
    @State var size: CGFloat = UIScreen.main.bounds.height - 70
    
    var body: some View {
        VStack {
            // For pushing v9ew up / down
            VStack {
                // top + bottom viwe up / down
                Text("Swipe up to see more")
                    .fontWeight(.heavy)
                    .padding([.top, .bottom], 15)
            }
            
            // Your custom view
            Text("hello top")
                .fontWeight(.heavy)
                .padding()
            Spacer()
            Text("hello bottom")
                .fontWeight(.heavy)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(15)
        .offset(y: size)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if value.translation.height > 0 {
                        self.size = value.translation.height
                    } else {
                        let temp = UIScreen.main.bounds.height - 70
                        self.size = temp + value.translation.height
                        
                        // in up wards value will be negative so we subtracting the value by one from bottom
                    }
                })
                .onEnded({ value in
                    if value.translation.height > 0 {
                        if value.translation.height > 200 {
                            self.size = UIScreen.main.bounds.height - 70
                        } else {
                            self.size = 45
                        }
                    } else {
                        if value.translation.height <= -200 {
                            self.size = 45
                        } else {
                            self.size = UIScreen.main.bounds.height - 70
                        }
                    }
                })
        )
        .animation(.spring(), value: size)
        .ignoresSafeArea()
    }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
            Swipe()
        }
        .ignoresSafeArea()
    }
}
