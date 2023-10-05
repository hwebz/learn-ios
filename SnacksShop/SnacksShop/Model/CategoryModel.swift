//
//  CategoryModel.swift
//  SnacksShop
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categoryList: [CategoryModel] = [
    CategoryModel(icon: "", title: "All"),
    CategoryModel(icon: "carrot", title: "Choco"),
    CategoryModel(icon: "birthday.cake", title: "Waffles"),
    CategoryModel(icon: "cup.and.saucer", title: "Toffee"),
    CategoryModel(icon: "mug", title: "Chips"),
]
