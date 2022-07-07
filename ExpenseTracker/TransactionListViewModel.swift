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
            }
            .store(in: &cancellables)

    }
}
