//
//  UserContentListView.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack {
                switch selectedFilter {
                    case .threads:
                        ForEach(viewModel.threads) { thread in
                            ThreadCell(thread: thread)
                                .transition(.move(edge: .leading))
                        }
                    case .replies:
                        ForEach(viewModel.replies) { reply in
                            ThreadReplyProfileCell(reply: reply)
                                .transition(.move(edge: .trailing))
                        }
                    case .likes:
                        Text("Likes Screen")
                }
            }
        }
        .padding(.vertical, 8)
    }
}
