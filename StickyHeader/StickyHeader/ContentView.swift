//
//  ContentView.swift
//  StickyHeader
//
//  Created by Personal on 19/03/2024.
//

import SwiftUI

let btnColor = Color.blue

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                imageView()
                GeometryReader { geo in
                    let minY = geo.frame(in: .global).minY
                    HStack {
                        Button(action: {}, label: {
                            Label("Message", systemImage: "message")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(width: 240, height: 45)
                                .background(
                                    btnColor, in: RoundedRectangle(cornerRadius: 30))
                        })
                        CButton(iconName: .x, action: {})
                        CButton(iconName: .in, action: {})
                    }
                    .frame(maxWidth: .infinity)
                    .offset(y: max(60 - minY, 0))
                }
                .frame(height: 50)
                .zIndex(1)
                GridView()
            }
        }
        .ignoresSafeArea()
    }
}

@ViewBuilder
func imageView() -> some View {
    GeometryReader { geo in
        let minY = geo.frame(in: .global).minY
        let isScrolling = minY > 0
        
        VStack {
            Image(.luffy)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: isScrolling ? 160 + minY : 160)
                .clipped()
                .offset(y: isScrolling ? -minY : 0)
                .blur(radius: isScrolling ? minY / 80 : 0)
                .scaleEffect(isScrolling ? 1 + minY / 2000 : 1)
                .overlay(alignment: .bottom) {
                    ZStack {
                        Image(.luffy)
                            .resizable()
                            .scaledToFill()
                        Circle().stroke(lineWidth: 6)
                    }
                    .frame(width: 110, height: 110)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .offset(y: 50)
                    .offset(y: isScrolling ? -minY : 0)
                }
            Group {
                VStack {
                    Text("MONKEY D. LUFFY")
                        .bold()
                        .font(.title)
                    Text("He is a captain of Straw Hat Pirate group, he love adventure and explore new things, foods, cultures and people. There are 10 people in his group, he always try hard to beat the enemy and bad people, protect good people.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: geo.size.width - 30)
                        .lineLimit(3)
                        .fixedSize()
                }
                .offset(y: isScrolling ? -minY : 0)
            }
            .padding(.vertical, 53)
        }
        
    }
    .frame(height: 335)
}

struct GridView: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
            ForEach(0 ..< 25) { item in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 180, height: 220)
                    .foregroundStyle(.ultraThinMaterial)
            }
        })
        .padding(.horizontal, 10)
    }
}

struct CButton: View {
    let iconName: UIImage
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(uiImage: iconName)
                .resizable()
                .scaledToFill()
                .frame(width: 23, height: 23)
                .padding(10)
                .background(btnColor, in: Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [btnColor, btnColor.opacity(0.3)]), startPoint: .bottomLeading, endPoint: .topTrailing))
                }
        }
    }
}

#Preview {
    ContentView()
}
