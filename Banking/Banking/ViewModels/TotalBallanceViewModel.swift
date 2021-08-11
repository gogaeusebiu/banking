//
//  TotalBallanceViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import Combine

final class TotalBallanceViewModel: ObservableObject {
    @Published var accountRepository = AccountRepository()
    @Published var totalBallance = 0.0

    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        accountRepository.$accounts.sink { accounts in
            self.totalBallance = 0.0
            for account in accounts {
                self.totalBallance += ConversionUtils.convertToRON(account)
            }
        }.store(in: &cancellables)
    }
}
