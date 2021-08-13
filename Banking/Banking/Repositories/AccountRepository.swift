//
//  AccountRepository.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class AccountRepository: ObservableObject {
    private let path = "accounts"
    private let store = Firestore.firestore()
    private let settings = FirestoreSettings()
    
    @Published var accounts: [AccountModel] = []
    
    init() {
        settings.isPersistenceEnabled = true
        store.settings = settings
        
        getAccounts()
    }
    
    func getAccounts() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.accounts = snapshot?.documents.compactMap({
                try? $0.data(as: AccountModel.self)
            }) ?? []
        }
    }
    
    func update(_ account: AccountModel) {
        if let documentId = account.id {
            do {
                _ = try store.collection(path).document(documentId).setData(from: account)
            } catch {
                print(error)
            }
        }
    }
}
