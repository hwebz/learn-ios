//
//  SettingsRowView.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    var description: String?
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
        
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
            
            if description != nil {
                Text(description!)
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray), description: "1.0.0")
    }
}
