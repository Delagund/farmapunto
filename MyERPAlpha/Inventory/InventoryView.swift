import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(\.modelContext) private var context
    @Query var inventories: [Inventory]
    
    var body: some View {
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
                            Text("\(inventory.qtyInStock)")
                        }
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.medium)
                    }
                }
            }
            .onDelete(perform: deleteItems)
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
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let inventory = inventories[offset]
                context.delete(inventory)
            }
        }
    }
}

#Preview {
    InventoryView()
}
