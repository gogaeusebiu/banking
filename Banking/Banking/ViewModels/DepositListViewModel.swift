//
//  DepositListViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Combine

final class DepositListViewModel: ObservableObject {
    @Published var depositRepository = DepositRepository()
    @Published var deposits: [DepositModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        depositRepository.$deposits.assign(to: \.deposits, on: self)
            .store(in: &cancellables)
    }
    
    func remove(_ deposit: DepositModel) {
        depositRepository.remove(deposit)
    }
}
