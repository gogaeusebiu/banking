//
//  File.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import Foundation

class ConversionUtils {
    static func convertToRON(_ account: AccountModel) -> Double {
        switch account.currency {
        case "euro":
            return account.amount * 4.91
        case "dolar":
            return account.amount * 4.18
        default:
            return account.amount
        }
    }
}
