//
//  FrameworkTitleViewSecond.swift
//  Apple-Frameworks
//
//  Created by Personal on 23/09/2023.
//

import SwiftUI

struct FrameworkTitleViewSecond: View {
    let framework: Framework
    
    var body: some View {
        HStack {
            Image(framework.imageName)
                .resizable()
                .frame(width: 70, height: 70)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
                .padding()
        }
    }
}

struct FrameworkTitleViewSecond_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkTitleViewSecond(framework: MockData.sampleFramework)
    }
}
