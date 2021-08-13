//
//  AccountView.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import SwiftUI

struct AccountView: View {
    var account: AccountModel
    
    var body: some View {
        VStack(spacing:10) {
            HStack {
                VStack {
                    Text("\(account.accountNumber)")
                    Spacer()
                }
                Spacer()
            }
            VStack {
                HStack {
                    Spacer()
                    Text("\(String(format: "%.2f", account.amount))").fontWeight(.bold)
                    switch account.currency {
                    case "euro":
                        Image(systemName: "eurosign.circle")
                    case "dolar":
                        Image(systemName: "dollarsign.circle")
                    default:
                        Text("RON")
                    }
                }
            }
        }.padding(.all)
        .background(Color(.systemGray6))
    }
}
