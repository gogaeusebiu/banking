//
//  AccountModel.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import FirebaseFirestoreSwift

struct AccountModel: Identifiable, Codable {
    @DocumentID var id: String?
    var currency: String
    var amount: Double
    var accountNumber: String
}
