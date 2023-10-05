//
//  TransactionRow.swift
//  MoneyManager
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct TransactionRow: View {
    var body: some View {
        HStack {
            Image("visa")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(5)
            VStack(alignment: .leading) {
                Text("Dribble")
                    .font(.headline)
                Text("12 Nov 2023 11:08")
                    .font(.caption)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
            Text("~$60")
                .font(.headline)
        }
        .padding(10)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow()
    }
}
