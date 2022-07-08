//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import Foundation

var tranactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "cictec", account: "公户", merchant: "apple", amount: 11.49, type: "debit", categoryId: 801, category: "software", isPending: false, isTransfer: false, isExpense: false, isEdited: false)

var tranactionList = [Transaction](repeating: tranactionPreviewData, count: 10)

