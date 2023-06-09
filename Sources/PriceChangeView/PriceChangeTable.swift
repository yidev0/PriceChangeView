//
//  PriceChangeTable.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 16.0, macOS 12.0, *)
struct PriceChangeTable: View {
    
    #if !os(macOS)
    @Environment(\.horizontalSizeClass) var sizeClass
    #endif
    
    @Binding var type: PriceChangeType
    var items: [PriceChangeItem]
    
    init(items: [PriceChangeItem], type: Binding<PriceChangeType>) {
        self.items = items
        self._type = type
    }
    
    var body: some View {
        Table(items) {
            TableColumn("Country/Region") { item in
                #if os(macOS)
                Text(item.country)
                #else
                switch sizeClass {
                case .compact:
                    HStack {
                        Text(item.country)
                        Spacer()
                        PriceChangeLabel(item: item, type: $type)
                            .foregroundColor(.secondary)
                    }
                default:
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

@available(iOS 16.0, macOS 12.0, *)
struct PriceChangeTable_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeTable(
            items: [
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
            ],
            type: .constant(.diff)
        )
    }
}
