//
//  PriceChangeItem.swift
//
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

struct PriceChangeView: View {
    
    var fileName: String
    @State var items: [PriceChangeItem]
    @State var allItems: [PriceChangeItem]
    @State var search: String
    
    init(fileName: String) {
        self.fileName = fileName
        self._items = .init(initialValue: [])
        self._allItems = .init(initialValue: [])
        self._search = .init(initialValue: "")
    }
    
    var body: some View {
        navigation
            .onAppear {
                loadData()
            }
            .onChange(of: search) { newValue in
                if search == "" {
                    items = allItems
                } else {
                    items = allItems.filter { item in
                        item.country.contains(newValue.capitalized)
                    }
                }
            }
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
    }
    
    var navigation: some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            return NavigationStack {
                list
                    .searchable(text: $search)
            }
        } else {
            return NavigationView {
                list
                    .searchable(text: $search)
            }
        }
    }
    
    var list: some View {
        #if os(macOS)
        PriceChangeTable(items: items)
        #else
        if #available(iOS 16.0, *) {
            return PriceChangeTable(items: items)
        } else {
            return PriceChangeList(items: items)
        }
        #endif
    }
    
    func loadData() {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "csv") {
            do {
                var returnValue: [PriceChangeItem] = []
                let str = try String(contentsOf: url)
                let lines = str.split(separator: "\n")
                for line in lines {
                    if line == lines.first { continue }
                    let splitLine = line.split(separator: ",")
                    let item = PriceChangeItem(
                        country: String(splitLine[0]), currency: String(splitLine[1]),
                        currentPrice: Double(splitLine[2]) ?? 0,
                        newPrice: Double(splitLine[3]) ?? 0
                    )
                    returnValue.append(item)
                }
                items = returnValue.sorted(by: { $0.country < $1.country })
            } catch {
                print(error.localizedDescription)
                items = []
            }
        } else {
            items = []
        }
        allItems = items
    }
    
}
