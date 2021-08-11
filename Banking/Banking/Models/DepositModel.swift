//
//  DepositModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import FirebaseFirestoreSwift

struct DepositModel: Identifiable, Codable {
    @DocumentID var id: String?
    var amount: Double
    var amountGain: Double
    var depositNumber: String
    var createdDate: String
    var periodOfTimeYears: Int
}
