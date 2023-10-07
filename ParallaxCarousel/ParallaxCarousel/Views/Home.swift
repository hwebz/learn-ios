//
//  Home.swift
//  ParallaxCarousel
//
//  Created by Personal on 07/10/2023.
//

import SwiftUI

struct Home: View {
    let horizontalPadding: CGFloat = 30
    let cornerRadiusConstant: CGFloat = 10
    let paddingConstant: CGFloat = 10

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                header
                
                VStack(alignment: .leading) {
                    Text("Hi John,")
                        .opacity(0.5)
                        .padding(.bottom, -5)
                    
                    Text("Where do you wanna go?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                // Trip Cards
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(tripList) { card in
                                GeometryReader { geometry in
                                    let cardSize = geometry.size
                                    let minX = min(geometry.frame(in: .global).minX * 1.4, geometry.size.width + 1.4)
                                    
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x: -minX)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay(content: {
                                            OverlayView(card: card)
                                        })
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .shadow(color: .black.opacity(0.15), radius: 8, x: 5, y: 10)
                                }
                                .frame(width: size.width - 60, height: size.height - 60)
//                                .scrollTransition(.interactive, axis: .horizontal) { view, phase in
//                                    view.scaleEffect(phase.isIdentity ? 1 : 0.95)
//                                }
                            }
                        }
                        .padding(20)
//                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
//                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                }
                .frame(height: 500)
                .padding(.horizontal, -15)
                .padding(.top, 10)
            }
            .padding()
        }
    }
    
    var header: some View {
        HStack(spacing: 20) {
            HStack {
                Image(systemName: "map")
                Text("Sangrur, India")
            }
            .opacity(0.5)
            
            Spacer()
            
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .clipShape(Circle())
            
        }
    }
    
    @ViewBuilder
    func OverlayView(card: TripCard) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [.clear, .black.opacity(0.1), .black.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(card.title)")
                    .font(.title)
                    .bold()
                
                Text("\(card.subtitle)")
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
