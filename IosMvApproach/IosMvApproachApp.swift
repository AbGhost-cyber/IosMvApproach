//
//  IosMvApproachApp.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import SwiftUI

@main
struct IosMvApproachApp: App {
    private var service = OrderService(baseURL: URL(string: "https://island-bramble.glitch.me/orders")!)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(Model(orderService: service))
            }
        }
    }
}
