//
//  Extension-String.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import Foundation

extension String {
    
    func dateParsed() -> Date {
        
        guard let parsedDate = DateFormatter.china.date(from: self) else { return Date() }
        return parsedDate
    }
}
