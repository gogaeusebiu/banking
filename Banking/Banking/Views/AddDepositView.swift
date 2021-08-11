//
//  AddDepositView.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import SwiftUI

struct AddDepositView: View {
    @ObservedObject var createDepositViewModel: CreateDepositViewModel
    
//    @State private var showAmountGainText = false
    var didAddDeposit: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing:5) {
                    TextField("Amount", text: $createDepositViewModel.depositAmount)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    
                    Text(createDepositViewModel.inlineErrorForAmount)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                }.padding()
                
                DropdownView(dropdownTitle: "Period of time (years)", accountNumberList: ["1", "2", "3", "4", "5"], selectedAccountNumber: $createDepositViewModel.depositPeriod)
                    .padding()
                
                
//                Text("The amount gain at the end of deposit is \(createDepositViewModel.deposit.amountGain) RON")
//                    .padding()
//                    .font(.title3)
//                    .hidden()
                
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
            }
        }.navigationTitle("Create Deposit")
    }
}
