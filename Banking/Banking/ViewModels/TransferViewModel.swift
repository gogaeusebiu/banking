//
//  TransferViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 10.08.2021.
//

import Combine
import Foundation

final class TransferViewModel: ObservableObject {
    @Published var accountRepository = AccountRepository()
    @Published var accounts: [AccountModel] = []
    @Published var transferFromAccount = ""
    @Published var transferToAccount = ""
    @Published var transferAmount = ""
    
    @Published var inlineErrorForAmount = ""
    @Published var inlineErrorForAccounts = ""
    
    @Published var isValid = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var isTransferAmountEmptyPublisher: AnyPublisher<Bool, Never> {
        $transferAmount.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isTransferAmountValidNumberPublisher: AnyPublisher<Bool, Never> {
        $transferAmount.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Utils.numberPredicate.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var isTransferAmountToBigPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($transferAmount, $transferFromAccount)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map {
                let transfer = $1
                if let i = self.accounts.firstIndex(where: { $0.accountNumber == transfer }) {
                    return self.accounts[i].amount < Double($0) ?? 0
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
    
    private var areTransferAccountsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($transferToAccount, $transferFromAccount)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { return !$0.isEmpty && !$1.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var areTransferAccountsDifferentPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($transferToAccount, $transferFromAccount)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { return $0 != $1 }
            .eraseToAnyPublisher()
    }
    
    private var isAmountValidPublisher: AnyPublisher<AmountStatus, Never> {
        Publishers.CombineLatest3(isTransferAmountEmptyPublisher, isTransferAmountToBigPublisher, isTransferAmountValidNumberPublisher)
            .map {
                if $0 { return AmountStatus.amountEmpty }
                if $1 { return AmountStatus.amountIsToBig }
                if !$2 { return AmountStatus.amountIsNotANumber }
                return AmountStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var areTransferAccountsValidPublisher: AnyPublisher<AccountStatus, Never> {
        Publishers.CombineLatest(areTransferAccountsDifferentPublisher, areTransferAccountsFilledPublisher)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map {
                if $0 { return AccountStatus.accountsAreDifferet}
                if $1 { return AccountStatus.accountEmpty }
                return AccountStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isTransferValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isAmountValidPublisher, areTransferAccountsDifferentPublisher, areTransferAccountsFilledPublisher)
            .map {
                $0 == .valid && $1 && $2
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        accountRepository.$accounts.assign(to: \.accounts, on: self)
            .store(in: &cancellables)
        
        isTransferValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
        isAmountValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { amountStatus in
                switch amountStatus {
                case .amountEmpty:
                    return "Amount must contain a value"
                case .amountIsNotANumber:
                    return "Amount is not a valid number"
                case .amountIsToBig:
                    return "Amount is to big"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorForAmount, on: self)
            .store(in: &cancellables)
        
        areTransferAccountsValidPublisher
            .dropFirst()
            .map { accountStatus in
                   switch accountStatus {
                   case .accountEmpty:
                       return "Please select account"
                   case .accountsAreDifferet:
                       return "You selected the same account"
                   case .valid:
                       return ""
                   }
            }
            .assign(to: \.inlineErrorForAccounts, on: self)
            .store(in: &cancellables)
    }
    
    func transfer() {
        let i = self.accounts.firstIndex(where: { $0.accountNumber == self.transferFromAccount })!
        var fromAccount = self.accounts[i]
        fromAccount.amount -= Double(self.transferAmount)!
        accountRepository.update(fromAccount)
        
        let j = self.accounts.firstIndex(where: { $0.accountNumber == self.transferToAccount })!
        var toAccount = self.accounts[j]
        toAccount.amount += ConversionUtils.convert(fromAccount.currency, toAccount.currency, for: Double(self.transferAmount)!)
        accountRepository.update(toAccount)
    }
}
