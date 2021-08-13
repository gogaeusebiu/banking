//
//  DepositListViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Combine
import Foundation

final class DepositListViewModel: ObservableObject {
    @Published var depositRepository = DepositRepository()
    @Published var accountRepository = AccountRepository()
    @Published var accounts: [AccountModel] = []
    @Published var deposits: [DepositModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        depositRepository.$deposits.assign(to: \.deposits, on: self)
            .store(in: &cancellables)
        accountRepository.$accounts.assign(to: \.accounts, on: self)
            .store(in: &cancellables)
    }
    
    func collectDeposit(deposit: DepositModel) {
        depositRepository.remove(deposit)
        
        //update RON account with the amount gain from completing the deposit
        let i = self.accounts.firstIndex(where: { $0.currency == "leu" })!
        var ronAaccount = self.accounts[i]
        ronAaccount.amount += deposit.amountGain
        accountRepository.update(ronAaccount)
    }
    
    func remove(with indexSet: IndexSet) {
        guard let depositIndex = indexSet.first else { return }
        
        depositRepository.remove(deposits[depositIndex])
        
        //update RON account with the amount put in deposit
        let i = self.accounts.firstIndex(where: { $0.currency == "leu" })!
        var ronAaccount = self.accounts[i]
        ronAaccount.amount += deposits[depositIndex].amount
        accountRepository.update(ronAaccount)
    }
}
