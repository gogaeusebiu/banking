//
//  AccountViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import Combine

final class AccountListViewModel: ObservableObject {
    @Published var accountRepository = AccountRepository()
    @Published var accounts: [AccountModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        accountRepository.$accounts.assign(to: \.accounts, on: self)
            .store(in: &cancellables)
    }
    
    func update(_ account: AccountModel) {
        accountRepository.update(account)
    }
    
    func transfer(_ amount: Double,_ fromAccount: AccountModel, _ toAccount: AccountModel) {
        if fromAccount.amount < amount {
            return
        }
        
    }
}
