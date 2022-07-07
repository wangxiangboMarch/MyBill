//
//  Extension-Date.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/7.
//

import Foundation

extension DateFormatter {
    /// 这种方式保证只运行一次， 并且只有一个实例对象
    static let china: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
