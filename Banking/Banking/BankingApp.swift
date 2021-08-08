//
//  BankingApp.swift
//  Banking
//
//  Created by Goga Eusebiu on 06.08.2021.
//

import SwiftUI
import Firebase

@main
struct BankingApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
