//
//  CardList.swift
//  MoneyManager
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct CardList: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                Button {
                    print("Add new card")
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 2, dash: [2.0]))
                        )
                        .foregroundColor(.gray)
                }
                LazyHStack(alignment: .top, spacing: 15) {
                    ForEach(0..<10, id: \.self) { item in
                        CardView(isSelected: item == 0)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                }
                .fixedSize()
                .padding(.trailing, 20)
            }
            .padding(20)
        }
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList()
    }
}
