//
//  Model.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import Foundation

/*
 Aggregate root models can also communicate with each other to access entities that
 are not under their context. For example: A Shipping root model can access the
 Customer Management root model to find the information about a particular customer.
 */
enum OrderError: Error {
    case custom(String)
}

@MainActor
class Model: ObservableObject {
    
    @Published var orders: [Order] = []
    let orderService: OrderService
    
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    
    //    func sortOrders() ->  {
    //
    //    }
    //    func filterOrders() ->  {
    //
    //    }
    
    
    func getAllOrders() async throws {
        // you can call a Cache layer to see if the orders are already in the cache
        // if the orders are in the cache then return from the cache
        // otherwise fetch orders by making a network call
        
        self.orders = try await orderService.getAllOrders()
    }
    
    func placeOrder(_ order:Order) async throws {
        guard let newOrder = try await orderService.placeOrder(order) else {
            throw OrderError.custom("Unable to place an order.")
        }
        orders.append(newOrder)
    }
    
    func updateOrder(_ order:Order) async throws {
        guard let updatedOrder = try await orderService.updateOrder(order) else {
            throw OrderError.custom("Unable to update an order.")
        }
        guard let index = orders.firstIndex(where: {$0.id == updatedOrder.id}) else {
            return
        }
        orders[index] = updatedOrder
    }
}
