import SwiftUI
import SwiftData

struct InventoryTabView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Query var inventories: [Inventory]
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Inventory.product.productName)]
    
    var body: some View {
       
        InventoryView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Inventario")
            .navigationDestination(for: Inventory.self) { inventory in
                InventoryDetailView(inventory: inventory)
            }
            .toolbar {
                Menu("Orden", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Nombre A-Z")
                            .tag([SortDescriptor(\Inventory.product.productName)])
                        
                        Text("Nombre Z-A")
                            .tag([SortDescriptor(\Inventory.product.productName, order: .reverse)])
                    }
                }
            }
            .searchable(text: $searchText)
    }
}

#Preview {
    InventoryTabView()
}
