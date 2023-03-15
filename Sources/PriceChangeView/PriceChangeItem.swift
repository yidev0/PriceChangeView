//
//  PriceChangeItem.swift
//  
//
//  Created by Yuto on 2023/03/15.
//

import Foundation

public enum PriceChangeType: Int {
    case diff = 0, newPrice, currentPrice
}

struct PriceChangeItem: Identifiable {
    var id: String
    
    let country: String
    let currency: String
    let currentPrice: Double
    let newPrice: Double
    
    init(
        country: String,
        currency: String,
        currentPrice: Double,
        newPrice: Double
    ) {
        self.id = country
        self.country = country.replacingOccurrences(of: "\"", with: "")
        self.currency = currency
        self.currentPrice = currentPrice
        self.newPrice = newPrice
    }
    
    func getSymbol() -> String {
        let locale = NSLocale(localeIdentifier: currency)
        if locale.displayName(forKey: .currencySymbol, value: currency) == currency {
            let newlocale = NSLocale(localeIdentifier: currency.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: currency) ?? ""
        }
        
        var returnValue = locale.displayName(forKey: .currencySymbol, value: currency) ?? ""
        if returnValue.contains("$") && returnValue.count > 1 {
            returnValue = "$"
        }
        return returnValue
    }
}
