//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var tansactionVM: TransactionListViewModel
    
//    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24.0) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    let data = tansactionVM.accumulateTransactions()
                    
                    if !data.isEmpty {
                        let totalExpense = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel("￥\(totalExpense)", type: .title, format: "￥%.02f")
                                LineChart()
                            }
                            .background(Color.systemBackGround)
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: .systemBackGround,
                                           foregroundColor: ColorGradient(.blue, .purple)))
                        .frame(height: 300)
                    }

                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon ,.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        // 主题色
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let tansactionVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = tranactionList
        return vm
    }()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(tansactionVM)
    }
}
