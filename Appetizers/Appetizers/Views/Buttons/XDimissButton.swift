//
//  XDimissButton.swift
//  Appetizers
//
//  Created by Personal on 29/09/2023.
//

import SwiftUI

struct XDimissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .opacity(0.6)
            
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(.black)
        }
    }
}

struct XDimissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDimissButton()
    }
}
