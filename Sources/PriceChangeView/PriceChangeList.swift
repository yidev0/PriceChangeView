//
//  PriceChangeList.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeList: View {
    
    @State var type: PriceChangeType = .diff
    var items: [PriceChangeItem]
    
    init(items: [PriceChangeItem]) {
        self.items = items
    }
    
    var body: some View {
        List {
            ForEach(items, id: \.country) { item in
                PriceChangeCell(item: item, type: $type)
            }
        }
        .toolbar {
            ToolbarItem {
                PriceChangePicker(type: $type)
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeList_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeList(items: [
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
