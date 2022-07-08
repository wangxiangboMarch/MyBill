//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import Foundation
import Combine

final class TransactionListViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complete in
                switch complete {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("finish")
                }
            } receiveValue: { [weak self] models in
                self?.transactions = models
                dump(self?.transactions)
            }
            .store(in: &cancellables)

    }
    
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions, by: { $0.month })
        return groupedTransactions
    }
    
    /// 生成图表数据
    func accumulateTransactions() -> TransactionPrefixSum {
        print ("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        let today = "01/31/2022".dateParsed() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print ("dateInterval", dateInterval)
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0){ $0 - $1.signedAmount }.roundedTo2Digists()
            sum += dailyTotal
            sum = sum.roundedTo2Digists()
            cumulativeSum.append((date.formatted(),sum))
            print(date.formatted(),"dailyTotal:", dailyTotal, "sum:",sum)
            
        }
        return cumulativeSum
    }
}
