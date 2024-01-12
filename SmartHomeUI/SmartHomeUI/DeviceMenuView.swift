//
//  DeviceMenuView.swift
//  SmartHomeUI
//
//  Created by Personal on 06/01/2024.
//

import SwiftUI

var device = ["AC", "MUSIC", "LIGHTS", "SECURITY"]

struct DeviceMenuView: View {
    var devices: [String]
    @State private var selectedCategory: Int = 0
    var action: (String) -> ()
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geo in
                ScrollView(.horizontal) {
                    VStack {
                        HStack(spacing: 10) {
                            ForEach(0..<devices.count, id: \.self) { i in
                                DeviceItem(isSelected: i == selectedCategory, title: devices[i])
                                    .onTapGesture {
                                        selectedCategory = i
                                        action(devices[i])
                                    }
                            }
                        }
                    }
                    .frame(width: geo.size.width)
                }
                .scrollIndicators(.never)
            }
        }
    }
}

struct DeviceItem: View {
    var isSelected: Bool = false
    var title: String = "All"
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color.yellow : Color.white)
                .shadow(radius: 5)
                .overlay {
                    VStack(spacing: 5) {
                        Image(systemName: getDeviceIcon(deviceName: title))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(isSelected ? .white : .black)
                            .frame(width: isSelected ? 25 : 15, height: isSelected ? 25 : 15)
                        
                        Text(title)
                            .font(.system(size: 10))
                            .foregroundColor(isSelected ? .white : .black)
                            .bold(isSelected)
                    }
                }
                .frame(width: 70, height: 70)
        }
        .padding(5)
    }
}

func getDeviceIcon(deviceName: String) -> String {
    switch deviceName {
        case "AC":
            return "air.conditioner.horizontal.fill"
        case "MUSIC":
            return "opticaldisc.fill"
        case "LIGHTS":
            return "light.recessed"
        case "SECURITY":
            return "lock.circle"
        default:
            return "lock.circle"
    }
}

#Preview {
    DeviceMenuView(devices: device, action: { device in
        print(device)
    })
}
