//
//  PriceChangeItem.swift
//
//
//  Created by Yuto on 2023/03/15.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
public struct PriceChangeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private var fileName: String
    @State var items: [PriceChangeItem]
    @State var allItems: [PriceChangeItem]
    @State var search: String
    @State var type: PriceChangeType
    
    public init(fileName: String, type: PriceChangeType = .diff) {
        self.fileName = fileName
        self._items = .init(initialValue: [])
        self._allItems = .init(initialValue: [])
        self._search = .init(initialValue: "")
        self._type = .init(initialValue: type)
    }
    
    public var body: some View {
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
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Text("Done")
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
        PriceChangeTable(items: items, type: $type)
        #else
        if #available(iOS 16.0, *) {
            return PriceChangeTable(items: items, type: $type)
        } else {
            return PriceChangeList(items: items, type: $type)
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
