import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(\.modelContext) private var context
    @Query var inventories: [Inventory]
    
    var body: some View {
        Group{
            if inventories.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
                List {
                    ForEach(inventories) { inventory in
                        NavigationLink(value: inventory) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading){
                                    Text("SKU: \(inventory.product.code)")
                                    Text(inventory.product.productName)
                                }
                                .font(.caption2)
                                .fontWeight(.semibold)
                                Spacer()
                                HStack{
                                    Text("Stock:")
                                    Text("\(inventory.qtyInStock, specifier: "%.0f")")
                                }
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.medium)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Inventory>] = []) {
        _inventories = Query(filter: #Predicate { inventory in
            if searchString.isEmpty {
                true
            } else {
                inventory.product.productName.localizedStandardContains(searchString)
                || inventory.product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
}

#Preview {
    InventoryView()
}
