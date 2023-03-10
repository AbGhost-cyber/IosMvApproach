//
//  Order.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import Foundation

enum CoffeeSize: String, CaseIterable, Codable, Identifiable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    
    var id: Int {
        switch self {
            case .small:
                return 1
            case .medium:
                return 2
            case .large:
                return 3
        }
    }
}

struct Order: Codable, Identifiable {
    var id: Int?
    let name: String
    let coffeeName: String
    let total: Double
    let size: CoffeeSize
}
