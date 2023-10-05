//
//  CartManager.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    @Published private(set) var totalProducts: Int = 0
    
    func addToCart(product: Product) {
        var newProduct = product
        if products.contains(where: { $0.name == product.name }) {
            products = products.map {
                if $0.name == product.name {
                    newProduct = $0
                    if newProduct.quantity != nil {
                        newProduct.quantity! += 1
                    } else {
                        newProduct.quantity = 1
                    }
                    
                    return newProduct
                }
                return $0
            }
        } else {
            newProduct.quantity = 1
            products.append(newProduct)
        }
        total -= product.price
        totalProducts += 1
    }
    
    func removeFromCart(product: Product) {
        products = products.filter{ $0.id != product.id }
        total -= product.price
        totalProducts -= 1
    }
}
