//
//  PriceChangePicker.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

struct PriceChangePicker: View {
    
    @Binding var type: PriceChangeType
    
    var body: some View {
        Picker(selection: $type) {
            Label("Price Change", systemImage: "plus.forwardslash.minus")
                .tag(PriceChangeType.diff)
            Label("New Price", systemImage: "calendar.badge.clock")
                .tag(PriceChangeType.newPrice)
            Label("Current Price", systemImage: "calendar")
                .tag(PriceChangeType.currentPrice)
        } label: {
            Text("Detail")
        }
    }
}

struct PriceChangePicker_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangePicker(type: .constant(.diff))
    }
}
