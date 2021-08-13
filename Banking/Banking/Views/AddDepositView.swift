//
//  AddDepositView.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import SwiftUI

struct AddDepositView: View {
    @ObservedObject var createDepositViewModel: CreateDepositViewModel
    
    var didAddDeposit: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Create Deposit").font(.largeTitle)
                Spacer()
                VStack(spacing: 5) {
                    DropdownView(dropdownTitle: "Choose account", accountNumberList: createDepositViewModel.accounts.map({ account in
                        return account.accountNumber
                    }), selectedAccountNumber: self.$createDepositViewModel.transferFromAccount)
                    .padding()
                    
                    Text(self.createDepositViewModel.inlineErrorForAccount)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                }
                VStack(spacing:5) {
                    TextField("Amount", text: $createDepositViewModel.depositAmount)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .shadow(radius: 2)

                    
                    Text(createDepositViewModel.inlineErrorForAmount)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                }.padding()
                
                DropdownView(dropdownTitle: "Period of time (years)", accountNumberList: ["0","1", "2", "3", "4", "5"], selectedAccountNumber: $createDepositViewModel.depositPeriod)
                    .padding()
                
                
                Text(createDepositViewModel.inlineInfoTextForPeriod)
                    .padding()
                    .font(.title3)
                
                Spacer()
                Button {
                    createDepositViewModel.add()
                    didAddDeposit()
                } label: {
                    Text("Create Deposit")
                        .frame(width: 250, height: 50, alignment: .center)
                        .font(.title2)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.padding()
                .disabled(!createDepositViewModel.isValid)
                .shadow(radius: 2)

            }
        }
    }
}
