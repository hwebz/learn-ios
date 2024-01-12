//
//  ContentView.swift
//  SmartHomeUI
//
//  Created by Personal on 06/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            AnimatedBackground()
            VStack {
                Title()
                
                DeviceMenuView(devices: device) { value in
                    
                }
                .frame(height: 80)
                
                Spacer()
                
                TemperatureControlSliderView()
                
                Spacer()
                
                DeviceName()
                
                Button(action: {
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.yellow)
                        .overlay {
                            Text("SET TEMPERATURE")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .bold()
                        }
                })
                .frame(height: 60)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 50)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func Title() -> some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("BEDROOM")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .bold()
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("TOTAL 4 ACTIVE DEVICES")
                        .font(.system(size: 10))
                        .foregroundStyle(.yellow)
                        .bold()
                    
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func DeviceName() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Samsung AC")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
            }
            
            HStack {
                Text("Connected")
                    .font(.system(size: 15))
                    .foregroundStyle(.yellow)
                    .bold()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

#Preview {
    ContentView()
}
