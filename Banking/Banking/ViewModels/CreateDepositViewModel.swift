//
//  CreateDepositViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Combine

final class CreateDepositViewModel: ObservableObject {
    @Published var depositRepository = DepositRepository()
    @Published var depositPeriod = ""
    @Published var depositAmount = ""
    
    @Published var inlineErrorForAmount = ""
    
    @Published var isValid = true
    
    @Published var deposit: DepositModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        deposit = DepositModel(amount: 100, amountGain: 101, depositNumber: "BTRLRONDEPOSIT000000001", createdDate: "11.08.2021", periodOfTimeYears: 1)
    }
    
    func add() {
        depositRepository.add(deposit)
    }
}
