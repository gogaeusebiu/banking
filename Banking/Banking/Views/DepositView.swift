//
//  DepositView.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import SwiftUI

struct DepositView: View {
    @ObservedObject var depositListViewModel: DepositListViewModel
    
    @State private var showingForm = false
        
    var body: some View {
        NavigationView {
            ZStack {
                List(depositListViewModel.deposits) { deposit in
                    DepositCellView(deposit: deposit)
                }
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            showingForm = true
                        }) {
                            Circle()
                                .fill(Color.green)
                                .frame(height: 60)
                                .overlay(Image(systemName: "plus").foregroundColor(.white))
                        }.sheet(isPresented: $showingForm) {
                            AddDepositView(createDepositViewModel: CreateDepositViewModel()) {
                                showingForm = false
                            }
                        }
                    }
                }
            }
        }
    }
}
