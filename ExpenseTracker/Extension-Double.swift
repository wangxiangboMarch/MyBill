//
//  Extension-Double.swift
//  ExpenseTracker
//
//  Created by MacMini on 2022/7/8.
//

import Foundation

extension Double {
    
    func roundedTo2Digists() -> Double {
        return (self * 100).rounded() / 100
    }
}
