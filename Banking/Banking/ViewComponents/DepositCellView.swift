//
//  DepositCellView.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import SwiftUI

struct DepositCellView: View {
    var deposit: DepositModel
    var didCollectDeposit: (_ deposit: DepositModel) -> Void
    
    
    private func isFutureDate() -> Bool {
        let createdDate = AppDateFormatter.sharedManager.dateFromString(date: deposit.createdDate)
        let depositEndDate = AppDateFormatter.sharedManager.addYearsToDate(createdDate, deposit.periodOfTimeYears)
        
        return AppDateFormatter.sharedManager.isFutureDate(depositEndDate)
    }
    
    private func depositEndDateString() -> String {
        let createdDate = AppDateFormatter.sharedManager.dateFromString(date: deposit.createdDate)
        let depositEndDate = AppDateFormatter.sharedManager.addYearsToDate(createdDate, deposit.periodOfTimeYears)
        
        return AppDateFormatter.sharedManager.stringFromDate(date: depositEndDate)
    }
    
    private func getBackroundColor() -> Color {
        isFutureDate() ? Color(.systemGray6) : Color(.systemGreen)
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text(deposit.depositNumber).font(.system(size: 12)).padding(.all)
                Spacer()
                Text(deposit.createdDate).font(.system(size: 12)).padding(.all)
            }
            
            HStack {
                Text(String(format: "%.2f", deposit.amountGain)).font(.largeTitle).padding(.all)
                Spacer()
                Text("RON").font(.largeTitle).padding(.all)
            }
            
            HStack {
                Text("\(String(format: "%.2f", deposit.amount)) deposited").font(.system(size: 12)).padding(.all)
                Spacer()
            }
            
            HStack {
                Text("Deposit will be gain on \(self.depositEndDateString())").font(.system(size: 14)).padding(.all)
                Spacer()
            }
            
            HStack {
                if self.isFutureDate() {
                    Text("Swipe <- to delete and get the money now on RON account").font(.system(size: 14)).padding(.all)
                } else {
                    Spacer()
                    Button {
                        didCollectDeposit(self.deposit)
                    } label: {
                        Text("Collect Money")
                            .frame(width: 150, height: 30, alignment: .center)
                            .font(.system(size: 16))
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }.shadow(radius: 2)
                }
                Spacer()
                
            }.padding(.bottom)
            
        }.background(getBackroundColor())
    }
}
