//
//  TemperatureControlSliderView.swift
//  SmartHomeUI
//
//  Created by Personal on 07/01/2024.
//

import SwiftUI

struct TemperatureControlSliderView: View {
    @State var temperatureValue: CGFloat = 30.0
    @State var angleValue: CGFloat = 0.0
    let config = SliderConfig(
        minimumValue: 0.0, maximumValue: 40.0, totalValue: 40.0, knobRadius: 15.0, radius: 125.0
    )
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .butt, miterLimit: 0, dash: [3, 3], dashPhase: 0))
                .foregroundColor(.yellow)
                .frame(width: config.radius * 2.5, height: config.radius * 2.5)
            
            Circle()
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: config.radius * 2.25, height: config.radius * 2.25)
            
            Circle()
                .trim(from: 0.0, to: temperatureValue / config.totalValue)
                .stroke(temperatureValue < config.maximumValue / 1.1 ? .yellow : .red, lineWidth: 10)
                .frame(width: config.radius * 2, height: config.radius * 2)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .fill(temperatureValue < config.maximumValue / 1.1 ? .white : .red)
                .overlay {
                    Circle()
                        .fill(.gray)
                        .shadow(radius: 10)
                        .frame(width: config.knobRadius, height: config.knobRadius)
                }
                .frame(width: config.knobRadius * 1.5, height: config.knobRadius * 1.5)
                .padding(10)
                .offset(y: -config.radius)
            
            Circle()
                .fill(temperatureValue < config.maximumValue / 1.1 ? .white : .red)
                .overlay {
                    Circle()
                        .fill(.gray)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .frame(width: config.knobRadius, height: config.knobRadius)
                }
                .frame(width: config.knobRadius * 1.5, height: config.knobRadius * 1.5)
                .padding(10)
                .offset(y: -config.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({ value in
                            change(location: value.location)
                        })
                )
            
            Circle()
                .frame(width: config.radius * 1.7, height: config.radius * 1.7)
                .foregroundStyle(.white)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 10)
                .overlay {
                    VStack {
                        Text("\(String.init(format: "%.0f", temperatureValue))°C")
                            .font(.title)
                            .foregroundStyle(.black)
                            .bold()
                        Text("Celcious")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text("23 Min Left")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
        }
    }
    
    private func change(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)
        let angle = atan2(vector.dy - (config.knobRadius), vector.dx - (config.knobRadius)) + .pi / 2.0
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if value >= config.minimumValue && value <= config.maximumValue {
            temperatureValue = value
            angleValue = fixedAngle * 180 / .pi
        }
    }
    
    struct SliderConfig {
        let minimumValue: CGFloat
        let maximumValue: CGFloat
        let totalValue: CGFloat
        let knobRadius: CGFloat
        let radius: CGFloat
    }
}

#Preview {
    TemperatureControlSliderView()
}
