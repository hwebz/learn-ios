//
//  OrderView.swift
//  Appetizers
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(MockData.orderItems) { orderItem in
                        AppetizerListCell(appetizer: orderItem)
                    }
                }
                .listStyle(PlainListStyle())
                
                Button {
                    print("order placed")
                } label: {
                    APButton(title: "$99.99 - Place Order")
                }
                .padding(.bottom, 25)
            }
            .navigationTitle("🧾 Orders")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
