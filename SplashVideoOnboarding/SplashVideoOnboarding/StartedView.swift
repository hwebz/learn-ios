//
//  StartedView.swift
//  SplashVideoOnboarding
//
//  Created by Personal on 25/03/2024.
//

import SwiftUI

struct StartedView: View {
    @State var show = false
    @Binding var Dshow: Bool
    var body: some View {
        VStack {
            Spacer()
            Text("Hello").font(show ? .title2 : .system(size: 60))
                .offset(y: show ? -35 : 0)
            Group {
                Text("Travel. Explore").font(.largeTitle)
                Text("share, enjoy").font(.title)
                ButtonStyle(icon: "", title: "Get started") {
                    Dshow.toggle()
                }
                .padding(.horizontal)
            }
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.8)
            .offset(y: show ? -30 : 100)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        show.toggle()
                    }
                }
            }
        }
        .foregroundStyle(.white)
        .opacity(Dshow ? 0 : 1)
        .scaleEffect(Dshow ? 0.8 : 1, anchor: .bottom)
    }
}

struct ButtonStyle: View {
    var icon: String
    var title: String
    var action: () -> Void
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            HStack {
                if !icon.isEmpty {
                    Image(icon).resizable()
                        .frame(width: 30, height: 30)
                }
                Text(title).font(.title2)
            }
            .foregroundStyle(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white, in: .rect(cornerRadius: 30))
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 0.1)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    StartedView(Dshow: .constant(false))
}
