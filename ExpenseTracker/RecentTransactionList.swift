//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/8.
//

import SwiftUI

struct RecentTransactionList: View {
    
    @EnvironmentObject var tansactionVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("RecentTransaction")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }

            }
            .padding(.top)
            
            ForEach(Array(tansactionVM.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackGround)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    
    static var tansactionVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = tranactionList
        return vm
    }()
    
    static var previews: some View {
        Group {
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
                
        }
        .environmentObject(tansactionVM)
    }
}
