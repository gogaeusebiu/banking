//
//  DepositCellView.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import SwiftUI

struct DepositCellView: View {
    var deposit: DepositModel
    
    var body: some View {
        VStack(spacing:10) {
            HStack {
                Text(deposit.depositNumber).font(.system(size: 12)).padding(.all)
                Spacer()
                Text(deposit.createdDate).font(.system(size: 12)).padding(.all)
            }
            
            HStack {
                Text(String(deposit.amountGain)).font(.largeTitle).padding(.all)
                Spacer()
                Text("RON").font(.largeTitle).padding(.all)
            }
            
            HStack {
                Text("\(String(format: "%.2f", deposit.amount)) deposited").font(.system(size: 12)).padding(.all)
                Spacer()
            }
            
            HStack {
                Text("Deposit will be gain on \(deposit.periodOfTimeYears)").font(.system(size: 14)).padding(.all)
                Spacer()
            }
        }
    }
}
