//
//  FrameworkGridViewModel.swift
//  Apple-Frameworks
//
//  Created by Personal on 23/09/2023.
//

import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
    var selectedFramework: Framework? {
        didSet {
            isShowingDetailView = true
        }
    }
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Published var isShowingDetailView = false
}
