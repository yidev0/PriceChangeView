//
//  PriceChangeCell.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeCell: View {
    
    var item: PriceChangeItem
    @Binding var type: PriceChangeType
    
    var body: some View {
        HStack {
            Text(item.country)
            Text("(" + item.currency + ")")
            Spacer()
            PriceChangeLabel(item: item, type: $type)
                .foregroundColor(.secondary)
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeCell_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeCell(
            item: .init(
                country: "United States",
                currency: "USD",
                currentPrice: 1.99,
                newPrice: 99.99
            ),
            type: .constant(.diff)
        )
    }
}
