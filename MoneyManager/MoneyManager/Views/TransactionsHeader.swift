//
//  TransactionsHeader.swift
//  MoneyManager
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct TransactionsHeader: View {
    var body: some View {
        HStack {
            Text("Send to money")
                .font(.headline)
            Spacer()
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(Color("btnColor"))
                .frame(width: 30, height: 30)
            Text("Add recepient")
                .font(.headline)
        }
        .padding(20)
        .padding(.bottom, 40)
        .foregroundColor(.white)
        .background(Color("transactionBg"))
        .cornerRadius(20)
    }
}

struct TransactionsHeader_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsHeader()
    }
}
