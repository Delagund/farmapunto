import SwiftUI
import SwiftData

///Vista de lista de producto por stock
struct InventoryView: View {
    @Environment(\.modelContext) private var context
    @Query var inventories: [Inventory]
    
    var body: some View {
        Group{
            if inventories.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
//TODO: cambiar a LAzyVGrid para evitar que se carguen muchos datos de una sola vez
                List {
                    ForEach(inventories) { inventory in
                        NavigationLink(value: inventory) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading){
                                    Text("SKU: \(inventory.product.code)")
                                    Text(inventory.product.productName)
                                        .fontWeight(.semibold)
                                }
                                .font(.caption2)
                                
                                Spacer()
                                HStack{
                                    LabeledContent("Stock Actual:", value: "\(inventory.qtyInStock)")
                                }
                                .font(.system(size: 15, design: .rounded))
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
