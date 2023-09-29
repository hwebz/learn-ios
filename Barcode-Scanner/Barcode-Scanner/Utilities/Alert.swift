//
//  Alert.swift
//  Barcode-Scanner
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(
        title: Text("Invalid Device Input"),
        message: Text("Something is wrong with the camera. We are unable to capture the input."),
        dismissButton: .default(Text("OK"))
    )
    static let invalidScannedType = AlertItem(
        title: Text("Invalid Scan Input"),
        message: Text("The value scanned is not valid. This app scans EAN-8 an EAN-13."),
        dismissButton: .default(Text("OK"))
    )
}
