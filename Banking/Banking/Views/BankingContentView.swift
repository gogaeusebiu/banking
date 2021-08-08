//
//  BankingContentView.swift
//  Banking
//
//  Created by Goga Eusebiu on 06.08.2021.
//

import SwiftUI

struct BankingContentView: View {
    @ObservedObject var totalBallanceViewModel: TotalBallanceViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            Image("bella")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
            Spacer()
            VStack(spacing: 5) {
                Text("Total Ballance:")
                Text("\(String(format: "%.2f", totalBallanceViewModel.totalBallance)) RON")
            }.padding(15)
        }
        
        TabView {
            HomeView(accountListViewModel: AccountListViewModel()).tabItem {
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
        BankingContentView(totalBallanceViewModel: TotalBallanceViewModel())
    }
}
