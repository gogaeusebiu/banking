//
//  BankingContentView.swift
//  Banking
//
//  Created by Goga Eusebiu on 06.08.2021.
//

import SwiftUI

struct BankingContentView: View {
    var body: some View {
        Image("bella")
            .clipShape(Circle())
            .shadow(radius: 10)
            .overlay(Circle().stroke(Color.red, lineWidth: 5))
        TabView {
            HomeView().tabItem {
                Image(systemName: "house.circle")
                Text("Home")
            }
            
            DepositView().tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Deposits")
            }
            
            TransferView().tabItem {
                Image(systemName: "arrow.up.arrow.down.circle")
                Text("Transfer")
            }
        }
    }
}

struct BankingContentView_Previews: PreviewProvider {
    static var previews: some View {
        BankingContentView()
    }
}
