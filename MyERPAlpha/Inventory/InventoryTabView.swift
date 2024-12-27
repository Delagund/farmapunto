//
//  InventoryTabView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 20-12-24.
//

import SwiftUI
import SwiftData

struct InventoryTabView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Query var inventories: [Inventory]
    
    @State private var path = [Inventory]()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Inventory.product.productName)]
    
    var body: some View {
       
        InventoryView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Inventario")
            .navigationDestination(for: Inventory.self) { inventory in
                InventoryDetailView(inventory: inventory)
            }
            .searchable(text: $searchText)

    }
}

#Preview {
    InventoryTabView()
}
