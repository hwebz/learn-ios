//
//  OrderView.swift
//  Appetizers
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order: Order
    
//    @State private var orderItems = MockData.orderItems
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(order.items) { orderItem in
                            AppetizerListCell(appetizer: orderItem)
                        }
    //                    .onDelete(perform: { indexSet in
    //                        orderItems.remove(atOffsets: indexSet)
    //                    })
//                        .onDelete(perform: deleteItems)
                        .onDelete(perform: order.remove)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order placed")
                    } label: {
                        Text("$\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
//                    .modifier(StandardButtonStyle())
                    .standardButtonStyle()
                    .padding(.bottom, 25)
                }
                
//                if orderItems.isEmpty {
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order", message: "You have no items in your order. Please add an appetizer!")
                }
            }
            .navigationTitle("🧾 Orders")
        }
    }
    
//    func deleteItems(at offsets: IndexSet) {
//        orderItems.remove(atOffsets: offsets)
//    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
