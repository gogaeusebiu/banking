//
//  DepositRepository.swift
//  Banking
//
//  Created by Goga Eusebiu on 11.08.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class DepositRepository: ObservableObject {
    private let path = "deposits"
    private let store = Firestore.firestore()
    @Published var deposits: [DepositModel] = []
    
    init() {
        getDeposits()
    }
    
    func getDeposits() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.deposits = snapshot?.documents.compactMap({
                try? $0.data(as: DepositModel.self)
            }) ?? []
        }
    }
    
    func add(_ deposit: DepositModel) {
        do {
            _ = try store.collection(path).addDocument(from: deposit)
        } catch {
            print(error)
        }
    }
    
    func remove(_ deposit: DepositModel) {
        guard let documentId = deposit.id else { return }
        store.collection(path).document(documentId).delete() { error in 
            if let error = error {
                print(error)
                return
            }
        }
    }
}

