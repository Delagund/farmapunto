import SwiftUI
import SwiftData

struct ProductTabView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.productName)]

    var body: some View {
        
        ProductView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Productos")
            .navigationDestination(for: Product.self) { product in
                EditProductView(product: product)
            }
            .toolbar {
                Menu("Orden", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Nombre A-Z")
                            .tag([SortDescriptor(\Product.productName)])
                        
                        Text("Nombre Z-A")
                            .tag([SortDescriptor(\Product.productName, order: .reverse)])
                    }
                }
                Button(action: addItem) {
                    Label("Add Product", systemImage: "plus")
                }
                
            }
            .searchable(text: $searchText)
    }

    private func addItem() {
        withAnimation {
            let newProduct = Product(code: "", productName: "PRODUCTO")
            context.insert(newProduct)
            
            let newInventory = Inventory(product: newProduct, qtyInStock: 0)
            context.insert(newInventory)
    
            let newTransaction = Transaction(product: newProduct, netPrice: 0.0, taxFee: 19, revenue: 20, storedFinalPrice: 0)
            context.insert(newTransaction)
        }
    }
}

#Preview {
    ProductTabView()
        .modelContainer(for: Product.self, inMemory: true)
}
