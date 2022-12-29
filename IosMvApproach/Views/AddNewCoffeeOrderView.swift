//
//  AddNewCoffeeOrderView.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import SwiftUI

struct AddNewCoffeeOrderError {
    var name: String = ""
    var coffeeName: String = ""
    var total: String = ""
}



struct AddNewCoffeeOrderView: View {
    @State private var state:AddCoffeeViewState
    = AddCoffeeViewState()
    
    let order: Order?
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: Model
    
    
    
    init(order:Order? = nil) {
        self.order = order
    }
    
    private func placeOrder(_ order: Order) async {
        try? await model.placeOrder(order)
        dismiss()
    }
    
    private func updateOrder(_ order: Order) async {
        try? await model.updateOrder(order)
        dismiss()
    }
    
    private func updateOrPlaceOrder() async {
        if let order {
            let order = Order(id: order.id, name: state.name, coffeeName: state.coffeeName, total: Double(state.total)!, size: state.size)
            await updateOrder(order)
        }else {
            //place order
            let order = Order(name: state.name, coffeeName: state.coffeeName, total: Double(state.total)!, size: state.size)
            await placeOrder(order)
        }
    }
    
    var body: some View {
            NavigationStack {
                Text(order != nil ? "Update Order": "Place Order")
                    .font(.title2)
                    .bold()
                Form {
                    TextField("Name", text: $state.name)
                    !state.errors.name.isEmpty ? Text(state.errors.name)
                        .foregroundColor(.red): nil
                    
                    TextField("Coffee name", text: $state.coffeeName)
                    !state.errors.coffeeName.isEmpty ? Text(state.errors.coffeeName)
                        .foregroundColor(.red): nil
                    
                    TextField("Total", text: $state.total)
                        .keyboardType(.decimalPad)
                    !state.errors.total.isEmpty ? Text(state.errors.total)
                        .foregroundColor(.red): nil
                    Picker("Coffee Size", selection: $state.size) {
                        ForEach(CoffeeSize.allCases) { coffeeSize in
                            Text(coffeeSize.rawValue).tag(coffeeSize)
                        }
                    }.pickerStyle(.segmented)
                }
                
                .onAppear {
                    if let order {
                        // editing mode
                        state.name = order.name
                        state.coffeeName = order.coffeeName
                        state.total = String(order.total)
                        state.size = order.size
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            Task {
                                if state.isValid() {
                                    await updateOrPlaceOrder()
                                }
                            }
                        }
                    }
                }
            }
    }
}

struct AddNewCoffeeOrderView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationStack {
            AddNewCoffeeOrderView().environmentObject(Model(orderService: OrderService(baseURL: URL(string: "https://island-bramble.glitch.me/orders")!)))
        }
    }
}
