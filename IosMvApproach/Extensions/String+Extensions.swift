//
//  String+Extensions.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import Foundation

extension String {
    
    var isNumeric: Bool {
        Double(self) != nil ? true: false
    }
    
    func isLessThan(_ value: Double) -> Bool {
        guard let number = Double(self) else {
            return false
        }
        
        return number < value
    }
    
}
