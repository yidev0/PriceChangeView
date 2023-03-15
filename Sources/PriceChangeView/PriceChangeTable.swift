//
//  PriceChangeTable.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

struct PriceChangeTable: View {
    
    #if !os(macOS)
    @Environment(\.horizontalSizeClass) var sizeClass
    #endif
    
    @State var type: PriceChangeType = .diff
    var items: [PriceChangeItem]
    
    init(items: [PriceChangeItem]) {
        self.items = items
    }
    
    var body: some View {
        Table(items) {
            TableColumn("Country/Region") { item in
                #if os(macOS)
                Text(item.country)
                #else
                if sizeClass == .compact {
                    HStack {
                        Text(item.country)
                        Spacer()
                        PriceChangeLabel(item: item, type: $type)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text(item.country)
                }
                #endif
            }
            
            TableColumn("Current Price") { item in
                Text("\(item.getSymbol())\(item.currentPrice, specifier: "%.2f")")
            }
            
            TableColumn("New Price") { item in
                Text("\(item.getSymbol())\(item.newPrice, specifier: "%.2f")")
            }
            
            TableColumn("Difference") { item in
                Text("\(item.newPrice-item.currentPrice, specifier: "%.2f")")
            }
        }
        #if !os(macOS)
        .toolbar {
            if sizeClass == .compact {
                PriceChangePicker(type: $type)
            }
        }
        #endif
    }
}

struct PriceChangeTable_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeTable(items: [
            .init(
                country: "United States",
                currency: "USD",
                currentPrice: 1.99,
                newPrice: 99.99
            ),
            .init(
                country: "Canada",
                currency: "CAD",
                currentPrice: 2.99,
                newPrice: 109.99
            ),
        ])
    }
}
