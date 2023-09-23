//
//  FrameworkGridViewThird.swift
//  Apple-Frameworks
//
//  Created by Personal on 22/09/2023.
//

import SwiftUI

struct FrameworkGridViewThird: View {
    
    @StateObject var viewModel = FrameworkGridViewModelThird()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(MockData.frameworks, id: \.id) { framework in
                        NavigationLink(value: framework) {
                            FrameworkTitleView(framework: framework)
                        }
                    }
                }
            }
            .navigationTitle("🍎Frameworks")
            .navigationDestination(for: Framework.self) { framework in
                FrameworkDetailViewThird(framework: framework)
            }
        }
    }
}

struct FrameworkGridViewThird_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkGridViewThird()
    }
}
