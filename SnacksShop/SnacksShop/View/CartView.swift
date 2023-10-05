//
//  CartView.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Cart")
                        .font(.system(size: 30))
                        .padding(.trailing)
                    
                    Spacer()
                    
                    Text("\(cartManager.totalProducts)")
                        .imageScale(.large)
                        .padding()
                        .frame(width: 70, height: 90)
                        .background(.yellow.opacity(0.5))
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                    
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .padding()
                            .frame(width: 70, height: 90)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                    }
                    .foregroundColor(.black)
                }
                .padding(30)
                
                ScrollView(.vertical) {
                    // Cart Products
                    ForEach(cartManager.products) { item in
                        CartProductCard(product: item)
                            .environmentObject(cartManager)
                    }
                    .padding(.horizontal)
                }
                
                // Total Amount
                VStack(alignment: .leading) {
                    HStack {
                        Text("Delivery Amount")
                        Spacer()
                        Text("Free")
                            .font(.system(size: 24, weight: .semibold))
                    }
                    .padding(.bottom, 10)
                    
                    Text("Total Amount")
                        .font(.system(size: 24))
                    
                    Text("USD \(cartManager.total).00")
                        .font(.system(size: 36, weight: .semibold))
                }
                .padding(30)
                .frame(maxWidth: .infinity)
                .background(.yellow.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                
                // Button To Make Payment
                Button {
                    
                } label: {
                    Text("Make Payment")
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.yellow.opacity(0.5))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}


// Cart Product View
struct CartProductCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var product: Product
    
    var body: some View {
        HStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 80, height: 80)
                .background(.gray.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                
                Text(product.category)
                    .font(.callout)
                    .opacity(0.5)
            }
            
            Spacer()
            
            Text("\(product.quantity ?? 0)")
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
            
            Button {
                cartManager.removeFromCart(product: product)
            } label: {
                Image(systemName: "trash")
                    .imageScale(.small)
                    .padding()
                    .background(.red)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                
            }
            
            Text("$\(product.price).0")
                .padding()
                .background(.yellow.opacity(0.5))
                .clipShape(Capsule())
        }
    }
}
