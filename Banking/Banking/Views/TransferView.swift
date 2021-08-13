//
//  TransferView.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import SwiftUI
import Combine

struct TransferView: View {
    @ObservedObject var transferViewModel: TransferViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            
            DropdownView(dropdownTitle: "Choose account", accountNumberList: transferViewModel.accounts.map({ account in
                return account.accountNumber
            }), selectedAccountNumber: self.$transferViewModel.transferFromAccount)
            .padding()

            VStack(spacing:5) {
                TextField("Amount", text: $transferViewModel.transferAmount)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .shadow(radius: 2)

                    
                Text(self.transferViewModel.inlineErrorForAmount)
                    .foregroundColor(.red)
                    .font(.system(size: 12))
            }.padding()
            
            Image(systemName: "arrow.down")
            
            VStack(spacing: 5) {
                DropdownView(dropdownTitle: "Choose account", accountNumberList: transferViewModel.accounts.map({ account in
                    return account.accountNumber
                }), selectedAccountNumber: self.$transferViewModel.transferToAccount)
                .padding()
                
                Text(self.transferViewModel.inlineErrorForAccounts)
                    .foregroundColor(.red)
                    .font(.system(size: 12))
            }
            
            Spacer()
            Button {
                transferViewModel.transfer()
            } label: {
                Text("Transfer")
                    .frame(width: 250, height: 50, alignment: .center)
                    .font(.title2)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.padding()
            .disabled(!transferViewModel.isValid)
            .shadow(radius: 2)

            
        }
    }
}
