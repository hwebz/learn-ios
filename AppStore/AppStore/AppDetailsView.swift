//
//  AppDetailsView.swift
//  AppStore
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

struct AppDetailsView: View {
    @Binding var selectedApp: String?
    let appName: String
    var body: some View {
        VStack {
            Text(appName)
                .font(.largeTitle)
                .padding()
            // Add more detailed information about the app here
            Spacer()
            
            Button {
                selectedApp = nil
            } label: {
                Text("Close")
            }.buttonStyle(.borderedProminent)
        }
        .navigationTitle(appName)
    }
}

struct AppDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailsView(selectedApp: .constant(""), appName: "")
    }
}
