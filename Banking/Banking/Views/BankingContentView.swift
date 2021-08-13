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
        HStack() {
            Image("bella")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
                .shadow(radius: 5)
            VStack(spacing: 5) {
                HStack(spacing: 10) {
                    VStack(spacing: 5) {
                        Text("Accounts Ballance:")
                            .font(.system(size: 10))
                        
                        Text("\(String(format: "%.2f", totalBallanceViewModel.accountsBallance)) RON")
                            .font(.system(size: 14))
                        
                    }.padding()
                    VStack(spacing: 5) {
                        Text("Deposits Ballance:")
                            .font(.system(size: 10))
                        
                        Text("\(String(format: "%.2f", totalBallanceViewModel.depositsBallance)) RON")
                            .font(.system(size: 14))
                        
                    }.padding()
                }
                
                Text("Total: \(String(format: "%.2f", totalBallanceViewModel.accountsBallance + totalBallanceViewModel.depositsBallance)) RON")
                    .font(.system(size: 14))
            }
        }
        
        TabView {
            HomeView(accountListViewModel: AccountListViewModel()).tabItem {
                Image(systemName: "house.circle")
                Text("Home")
            }
            
            DepositView(depositListViewModel: DepositListViewModel()).tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Deposits")
            }
            
            TransferView(transferViewModel: TransferViewModel()).tabItem {
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
