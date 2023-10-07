//
//  CardModel.swift
//  ParallaxCarousel
//
//  Created by Personal on 07/10/2023.
//

import Foundation
import SwiftUI

struct TripCard: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var image: String
}

var tripList: [TripCard] = [
    TripCard(title: "Time Square", subtitle: "New York", image: "image-1"),
    TripCard(title: "Mountain View", subtitle: "Washington D.C", image: "image-2"),
    TripCard(title: "Old Trafford", subtitle: "California", image: "image-3"),
    TripCard(title: "Circle Stadium", subtitle: "Houston", image: "image-4")
]
