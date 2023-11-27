//
//  UserCell.swift
//  ThreadsClone
//
//  Created by Personal on 27/11/2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack(spacing: 10) {
            CircularProfileImageView()
            
            VStack(alignment: .leading) {
                Text("maxverstappen1")
                    .fontWeight(.semibold)
                
                Text("Max Verstappen")
            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundColor(Color(.systemGray4))
                }
        }
        .padding(.horizontal)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
