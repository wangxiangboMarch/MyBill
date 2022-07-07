//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
