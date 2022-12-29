//
//  AddCoffeeViewState.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import Foundation

struct AddCoffeeViewState {
    var name: String = ""
    var coffeeName: String = ""
    var total: String = ""
    var size: CoffeeSize = .medium
    var errors: AddNewCoffeeOrderError = AddNewCoffeeOrderError()
    
    mutating func isValid() -> Bool {
        errors.name = name.isEmpty ? "Name cannot be blank 🫣" : ""
        errors.coffeeName = coffeeName.isEmpty ? "Coffee name cannot be empty 😜" : ""
        
        if total.isEmpty {
            errors.total = "Total cannot be empty 🫠"
        } else if !total.isNumeric {
            errors.total = "Total can only be numbers 🕵️"
        } else if total.isLessThan(0) {
            errors.total = "Total cannot be less than 0 🕵️"
        } else {
            errors.total = ""
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.total.isEmpty
    }
}
