//
//  FrameworkDetailViewThird.swift
//  Apple-Frameworks
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

struct FrameworkDetailViewThird: View {
    var framework: Framework
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
                Label("Learn More", systemImage: "book.fill")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.red)
        }
        .sheet(isPresented: $isShowingSafariView, content: {
            SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
        })
    }
}

struct FrameworkDetailViewThird_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDetailViewThird(framework: MockData.sampleFramework)
    }
}
