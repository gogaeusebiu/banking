//
//  CreateDepositViewModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Combine
import Foundation

final class CreateDepositViewModel: ObservableObject {
    @Published var accountRepository = AccountRepository()
    @Published var depositRepository = DepositRepository()
    @Published var accounts: [AccountModel] = []
    @Published var transferFromAccount = ""
    @Published var depositPeriod = ""
    @Published var depositAmount = ""
    
    @Published var inlineErrorForAmount = ""
    @Published var inlineErrorForAccount = ""
    @Published var inlineInfoTextForPeriod = ""
    
    @Published var isValid = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var isTransferAccountFilledPublisher: AnyPublisher<Bool, Never> {
        $transferFromAccount
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { return !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isDepositAmountEmptyPublisher: AnyPublisher<Bool, Never> {
        $depositAmount.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isDepositAmountValidNumberPublisher: AnyPublisher<Bool, Never> {
        $depositAmount.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Utils.numberPredicate.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var isDepositAmountToBigPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($depositAmount, $transferFromAccount)
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
    
    private var isAmountValidPublisher: AnyPublisher<AmountStatus, Never> {
        Publishers.CombineLatest3(isDepositAmountEmptyPublisher, isDepositAmountToBigPublisher, isDepositAmountValidNumberPublisher)
            .map {
                if $0 { return AmountStatus.amountEmpty }
                if $1 { return AmountStatus.amountIsToBig }
                if !$2 { return AmountStatus.amountIsNotANumber }
                return AmountStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isPeriodInfoAvailablePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isAmountValidPublisher, $depositPeriod)
            .map { $0 == .valid && !$1.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isReadyToBeCreatedPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isPeriodInfoAvailablePublisher, isTransferAccountFilledPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    init() {
        accountRepository.$accounts.assign(to: \.accounts, on: self)
            .store(in: &cancellables)
        
        isTransferAccountFilledPublisher
            .receive(on: RunLoop.main)
            .map {
                if !$0 {
                    return "Please select account"
                }
                return ""
            }
            .assign(to: \.inlineErrorForAccount, on: self)
            .store(in: &cancellables)
        
        isReadyToBeCreatedPublisher
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
                    return "Amount is to big, please put more money in the RON account"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorForAmount, on: self)
            .store(in: &cancellables)
        
        isPeriodInfoAvailablePublisher
            .receive(on: RunLoop.main)
            .map { isPeriodInfoAvailable in
                if isPeriodInfoAvailable {
                    return "The amount gain at the end of deposit is \(String(format: "%.2f", Utils.calculateDepositAmountGain( Double(self.depositAmount)!, Double(self.depositPeriod)!))) RON"
                } else {
                    return ""
                }
            }
            .assign(to: \.inlineInfoTextForPeriod, on:self)
            .store(in: &cancellables)
    }
    
    func add() {
        //update account with the amount put in deposit
        let i = self.accounts.firstIndex(where: { $0.accountNumber == self.transferFromAccount })!
        var account = self.accounts[i]
        account.amount -= Double(self.depositAmount)!
        accountRepository.update(account)
        
        let ronAmount = ConversionUtils.convert(account.currency, "leu", for: Double(self.depositAmount)!)
        let deposit = DepositModel(amount: ronAmount,
                                   amountGain: Utils.calculateDepositAmountGain(ronAmount, Double(self.depositPeriod)!),
                                   depositNumber: "BTRLRONDEPOSIT\(Int.random(in: 1000..<10000))",
                                   createdDate: AppDateFormatter.sharedManager.stringFromDate(date: Date()),
                                   periodOfTimeYears: Int(self.depositPeriod)!)
        
        depositRepository.add(deposit)
    }
}
