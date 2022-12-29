//
//  RowView.swift
//  IosMvApproach
//
//  Created by dremobaba on 2022/12/29.
//

import SwiftUI

struct RowView: View {
    let order: Order
    let onLongPress:() -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading){
                Text(order.name)
                Text(order.coffeeName)
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
        }
        .padding(15)
        .contentShape(Rectangle())
        .onLongPressGesture {
            onLongPress()
        }
        .background(Color.primary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
    
    
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(order: Order(name: "Abundance", coffeeName: "Cupertino", total: 10.00, size: .medium)){
            
        }
    }
}
