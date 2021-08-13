//
//  HomeView.swift
//  Banking
//
//  Created by Goga Eusebiu on 08.08.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var accountListViewModel: AccountListViewModel
        
    var body: some View {
        List(accountListViewModel.accounts) { account in
            AccountView(account: account)
                .cornerRadius(5)
                .shadow(radius: 5)

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(accountListViewModel: AccountListViewModel())
    }
}
