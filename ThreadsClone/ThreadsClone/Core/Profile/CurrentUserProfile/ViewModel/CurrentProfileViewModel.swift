//
//  ProfileViewModel.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation
import Firebase
import Combine

class CurrentProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task { await setupSubscribers() }
    }
    
    @MainActor
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in view model from combine is \(user)")
        }
        .store(in: &cancellables)
    }
}
