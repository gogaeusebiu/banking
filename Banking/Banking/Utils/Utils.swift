//
//  Utils.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import Foundation

enum TransferAmountStatus {
    case amountEmpty
    case amountIsNotANumber
    case amountIsToBig
    case valid
}

class Utils {
    static let numberPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+\\.?[0-9]*$")
}
