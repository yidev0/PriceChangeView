//
//  PriceChangePicker.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
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

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangePicker_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangePicker(type: .constant(.diff))
    }
}
