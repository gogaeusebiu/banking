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
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(depositListViewModel.deposits) { deposit in
                        DepositCellView(deposit: deposit, didCollectDeposit: { deposit in
                            depositListViewModel.collectDeposit(deposit: deposit)
                        }).cornerRadius(5)
                        .shadow(radius: 5)

                    }.onDelete(perform: depositListViewModel.remove(with:))
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
                                .shadow(radius: 5)
                        }.sheet(isPresented: $showingForm) {
                            AddDepositView(createDepositViewModel: CreateDepositViewModel()) {
                                showingForm = false
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
        }.padding(.zero)
    }
}
