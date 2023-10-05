//
//  ProductModel.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

// Product Model
struct Product: Identifiable {
    var id: UUID = .init()
    var name: String
    var category: String
    var image: String
    var color: Color
    var price: Int
    var quantity: Int?
}

// Sample Products
var productList = [
    Product(name: "Good Source", category: "Choco", image: "choco", color: .pink, price: 22),
    Product(name: "Unreal Muffins", category: "Choco", image: "chip", color: .yellow, price: 12),
    Product(name: "Twister Chips", category: "Choco", image: "cheese", color: .red, price: 63),
    Product(name: "Regular Chips", category: "Waffles", image: "coca", color: .green, price: 102),
    Product(name: "Dark Russet", category: "Waffles", image: "corn", color: .blue, price: 77),
    Product(name: "Smiths Chips", category: "Toffee", image: "drink", color: .brown, price: 6),
    Product(name: "Deep River", category: "Toffee", image: "pop", color: .orange, price: 5),
    Product(name: "Blue Ocean", category: "Toffee", image: "snack", color: .purple, price: 33)
]
