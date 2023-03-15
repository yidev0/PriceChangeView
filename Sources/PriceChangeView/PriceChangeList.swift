//
//  PriceChangeList.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeList: View {

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
        List {
            ForEach(items, id: \.country) { item in
                PriceChangeCell(item: item, type: $type)
            }
        }
        .toolbar {
            ToolbarItem {
                #if !os(macOS)
                if sizeClass == .compact {
                    PriceChangePicker(type: $type)
                }
                #endif
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeList_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeList(
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
