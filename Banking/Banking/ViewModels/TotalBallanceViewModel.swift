//
//  TotalBallanceViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import Combine

final class TotalBallanceViewModel: ObservableObject {
    @Published var accountRepository = AccountRepository()
    @Published var depositRepository = DepositRepository()
    @Published var accountsBallance = 0.0
    @Published var depositsBallance = 0.0

    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        accountRepository.$accounts.sink { accounts in
            self.accountsBallance = 0.0
            for account in accounts {
                self.accountsBallance += ConversionUtils.convertToRON(account)
            }
        }.store(in: &cancellables)
        
        depositRepository.$deposits.sink { deposits in
            self.depositsBallance = 0.0
            for deposit in deposits {
                self.depositsBallance += deposit.amount
            }
        }.store(in: &cancellables)
    }
}
