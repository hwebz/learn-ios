//
//  CardsScreen.swift
//  MoneyManager
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct CardsScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("bgColor")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    CardList()
                    TransactionsView()
                }
                .navigationTitle(Text("My Cards"))
            }
        }

    }
}

struct CardsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CardsScreen()
    }
}
