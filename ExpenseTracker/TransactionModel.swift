//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import Foundation

struct Transaction: Identifiable, Codable {
    
    let id: Int
    let date: String
    /// 机构
    let institution: String
    /// 账户
    let account: String
    /// 商户
    var merchant: String
    /// 金额
    let amount: Double
    let type: TransactionType.RawValue
    
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
}

enum TransactionType: String {
    /// 借方
    case debit
    ///  贷方
    case credit
}
