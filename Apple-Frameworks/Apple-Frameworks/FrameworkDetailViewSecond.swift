//
//  FrameworkDetailViewSecond.swift
//  Apple-Frameworks
//
//  Created by Personal on 23/09/2023.
//

import SwiftUI

struct FrameworkDetailViewSecond: View {
    var framework: Framework
    @Binding var isShowingDetailView: Bool
    @State private var isShowingSafariView = false
    
    var body: some View {
        VStack {
            Spacer()
            FrameworkTitleView(framework: framework)
            Text(framework.description)
                .font(.body)
                .padding()
            Spacer()
            Button {
                isShowingSafariView = true
            } label: {
                AFButton(title: "Learn More")
            }
        }
//        .fullScreenCover(isPresented: $isShowingSafariView, content: {
        .sheet(isPresented: $isShowingSafariView, content: {
            SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
        })
    }
}

struct FrameworkDetailViewSecond_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDetailViewSecond(framework: MockData.sampleFramework, isShowingDetailView: .constant(false))
    }
}
