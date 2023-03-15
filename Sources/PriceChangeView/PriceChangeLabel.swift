//
//  PriceChangeLabel.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
public struct PriceChangeLabel: View {
    
    var item: PriceChangeItem
    @Binding var type: PriceChangeType
    
    public var body: some View {
        ZStack {
            switch type {
            case .newPrice:
                Text("\(item.getSymbol())\(item.newPrice, specifier: "%.2f")")
            case .currentPrice:
                Text("\(item.getSymbol())\(item.currentPrice, specifier: "%.2f")")
            case .diff:
                Text("\(item.getSymbol())\(item.newPrice - item.currentPrice, specifier: "%.2f")")
            }
        }
        .onTapGesture {
            type = PriceChangeType(rawValue: type.rawValue + 1) ?? .diff
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct PriceChangeLabel_Previews: PreviewProvider {
    static var previews: some View {
        PriceChangeLabel(
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
