//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/8.
//

import SwiftUI

struct TransactionList: View {
    
    @EnvironmentObject var tansactionVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(tansactionVM.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }
                }
            }
            .listSectionSeparator(.hidden)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var tansactionVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = tranactionList
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                TransactionList() 
            }
            NavigationView {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
                
        }
        .environmentObject(tansactionVM)
    }
}
