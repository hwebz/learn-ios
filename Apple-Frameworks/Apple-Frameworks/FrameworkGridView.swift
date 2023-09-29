//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Personal on 22/09/2023.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(MockData.frameworks, id: \.id) { framework in
                        //                FrameworkTitleView(name: framework.name, imageName: framework.imageName)
                        FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                }
            }
            .navigationTitle("🍎Frameworks")
            .sheet(isPresented: $viewModel.isShowingDetailView) {
//                FrameworkDetailView(framework: viewModel.selectedFramework!)
                FrameworkDetailView(viewModel: FrameworkDetailViewModel(framework: viewModel.selectedFramework!, isShowingDetailView: $viewModel.isShowingDetailView))
            }
        }
    }
}

struct FrameworkGridView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkGridView()
//            .preferredColorScheme(.dark)
    }
}
