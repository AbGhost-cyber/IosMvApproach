//
//  ContentView.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import SwiftUI

enum Sheets: Identifiable {
    case add
    case update(Order)
    
    var id: Int {
        switch self {
        case .add:
            return 1
        case .update(_):
            return 2
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject private var model: Model
    @State private var activeSheet: Sheets?
    
    
    var ordersTotal: Double {
        model.orders.reduce(0) { result, order in
            result + order.total
        }
    }
    var numbers:[Int] = [1,2,3,4]
//
//    init() {
//        UINavigationBar.appearance()
//            .largeTitleTextAttributes = [
//                .foregroundColor: UIColor.white
//            ]
//    }
    
    var body: some View {
       ScrollView {
            ForEach(model.orders){ order in
                RowView(order: order, onLongPress: {
                    activeSheet = .update(order)
                })
            }
            .onDelete { indexSet in
              
            }
            .onMove { indexSet, offset in
               
            }
        }.task {
            // asychronous code to be performed before the view appears
            do {
                try await model.getAllOrders()
            }catch {
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Add New Order") {
                    activeSheet = .add
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $activeSheet) {sheet in
            switch sheet {
            case .add:
                NavigationView {
                    AddNewCoffeeOrderView()
                }
            case .update(let order):
                NavigationView {
                    AddNewCoffeeOrderView(order: order)
                }
            }
        }
        
        .listRowSeparator(.hidden)
        .navigationViewStyle(.columns)
        .navigationTitle("My Orders")
        .padding([.vertical, .horizontal], 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .environmentObject(Model(orderService: OrderService(baseURL: URL(string: "https://island-bramble.glitch.me/orders")!)))
        }
    }
}
