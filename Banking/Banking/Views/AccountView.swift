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
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.white)
            .frame(height: 120)
            .overlay(
                ZStack {
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
                            Text("\(account.amount)").fontWeight(.bold)
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
                }
            )
    }
}
