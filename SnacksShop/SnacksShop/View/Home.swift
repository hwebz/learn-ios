//
//  Home.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    // Category View Properties
    @State var selectedCategory = "All"
    @State var products: [Product] = productList
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Header
                    HStack {
                        Text("Order From The Best OF **Snacks**")
                            .font(.system(size: 30))
                            .padding(.trailing)
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .padding()
                            .frame(width: 70, height: 90)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                    }
                    .padding(30)
                    
                    // Category List
                    CategoryListView
                    
                    // Collection View
                    HStack {
                        Text("Choco **Collection**")
                            .font(.system(size: 24))
                        
                        Spacer()
                        
                        NavigationLink {
                            CollectionView()
                                .environmentObject(cartManager)
                        } label: {
                            Image(systemName: "arrow.right")
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    
                    // Product List
                    ScrollView(.horizontal, showsIndicators: false) {
                        if products.count > 0 {
                            HStack {
                                ForEach(products) { item in
                                    ProductCard(product: item)
                                        .environmentObject(cartManager)
                                }
                            }
                        } else {
                            HStack {
                                Text("No Snack Found.")
                            }
                            .padding(30)
                        }
                    }
                }
                
            }
        }
    }
    
    // Category List View
    var CategoryListView: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoryList) { item in
                        Button {
                            selectedCategory = item.title
                            if item.title == "All" {
                                products = productList
                            } else {
                                products = productList.filter { $0.category == item.title }
                            }
                        } label: {
                            HStack {
                                if item.title != "All" {
                                    Image(systemName: item.icon)
                                        .foregroundColor(selectedCategory == item.title ? .yellow : .black)
                                }
                                
                                Text(item.title)
                            }
                            .padding()
                            .background(selectedCategory == item.title ? .black : .gray.opacity(0.1))
                            .foregroundColor(selectedCategory == item.title ? .white : .black)
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(CartManager())
    }
}

struct ProductCard: View {
    var product: Product
    
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -90)
                .rotationEffect(Angle(degrees: 30))
            
            VStack(alignment: .leading) {
                Text("\(product.name)")
                    .font(.system(size: 30, weight: .semibold))
                    .frame(width: 140)
                
                Text(product.category)
                    .font(.callout)
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                
                Spacer()
                
                HStack {
                    Text("$\(product.price).0")
                        .font(.system(size: 24, weight: .semibold))
                    Spacer()
                    Button {
                        cartManager.addToCart(product: product)
                    } label: {
                        Image(systemName: "basket")
                            .imageScale(.large)
                            .frame(width: 90, height: 68)
                            .background(.black)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        
                    }
                    .padding(.horizontal, -10)
                }
                .padding(.leading)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(.white.opacity(0.9))
                .clipShape(Capsule())
            }
            .padding(30)
        }
        .frame(width: 350, height: 422)
        .background(product.color.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 57))
        .padding(.leading, 20)
    }
}
