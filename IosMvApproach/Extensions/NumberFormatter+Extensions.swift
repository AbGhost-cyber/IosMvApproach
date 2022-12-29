//
//  NumberFormatter+Extensions.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
}
