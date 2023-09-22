//
//  FrameworkGridViewSecond.swift
//  Apple-Frameworks
//
//  Created by Personal on 23/09/2023.
//

import SwiftUI

struct FrameworkGridViewSecond: View {
    @StateObject var viewModel = FrameworkGridViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(MockData.frameworks, id: \.id) { framework in
                    NavigationLink(destination: FrameworkDetailViewSecond(framework: framework, isShowingDetailView: $viewModel.isShowingDetailView)) {
                        FrameworkTitleViewSecond(framework: framework)
                    }
                }
            }
            .navigationTitle("🍎Frameworks")
        }
        .accentColor(Color(.label))
    }
}

struct FrameworkGridViewSecond_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkGridViewSecond()
    }
}
