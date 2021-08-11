//
//  DropdownView.swift
//  Banking
//
//  Created by Goga Eusebiu on 09.08.2021.
//

import SwiftUI

struct DropdownView: View {
    var dropdownTitle = ""
    var accountNumberList: [String]
    
    @Binding var selectedAccountNumber: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(dropdownTitle)
                .font(.title3)
            
            DisclosureGroup(selectedAccountNumber, isExpanded: $isExpanded) {
                VStack {
                    ForEach(accountNumberList, id: \.self) { accountNumber in
                        Text(accountNumber)
                            .font(.system(size: 18))
                            .padding(.all)
                            .onTapGesture {
                                self.selectedAccountNumber = accountNumber
                                withAnimation {
                                    self.isExpanded.toggle()
                                }
                            }
                    }
                }
            }.accentColor(.white)
            .foregroundColor(.white)
            .font(.title2)
            .padding(.all)
            .background(Color.purple)
            .cornerRadius(5)
        }
    }
}
