import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(\.modelContext) private var context
    @Query var inventories: [Inventory]
    
    var body: some View {
        List {
            ForEach(inventories) { inventory in
                NavigationLink(value: inventory) {
                    VStack(alignment: .leading) {
                        Text(inventory.product.productName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        HStack{
                            Text("Qty")
                            Text("\(inventory.qtyInStock)")
                        }
                        .font(.system(size: 15, design: .rounded))
                        .fontWeight(.light)
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
