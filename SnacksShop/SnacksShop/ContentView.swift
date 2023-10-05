//
//  ContentView.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView: View {
    
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Home()
                    .environmentObject(cartManager)
                
                if (cartManager.totalProducts > 0) {
                    NavigationLink {
                        CartView()
                            .environmentObject(cartManager)
                    } label: {
                        HStack(spacing: 30) {
                            Text("\(cartManager.totalProducts)")
                                .padding()
                                .background(.yellow)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("Cart")
                                    .font(.system(size: 26, weight: .semibold))
                                
                                Text("\(cartManager.totalProducts) items")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            ForEach(cartManager.products.suffix(3)) { product in
                                Image(product.image)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(8)
                                    .frame(width: 60, height: 60)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .padding(.leading, -60)
                            }
                        }
                        .padding(30)
                        .frame(width: .infinity, height: 120)
                        .background(.black)
                        .cornerRadius(60, corners: [.topLeft, .topRight])
                        // .clipShape(RoundedRectangle(cornerRadius: 30))
                    .foregroundColor(.white)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
