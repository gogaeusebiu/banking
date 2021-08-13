//
//  Utils.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Foundation

enum AmountStatus {
    case amountEmpty
    case amountIsNotANumber
    case amountIsToBig
    case valid
}

enum AccountStatus {
    case accountEmpty
    case accountsAreDifferet
    case valid
}

class Utils {
    static let numberPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+\\.?[0-9]*$")
    
    static func calculateDepositAmountGain(_ amount: Double, _ period: Double) -> Double {
        return amount * ( 1 + period / 10 )
    }
}
