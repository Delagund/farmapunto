import SwiftUI
import SwiftData

///vista de productos - con creacion de nuevo producto - búsqueda y filtro alfabetico.
struct ProductListView: View {
    @Environment(\.modelContext) private var context
    
    @Binding var path: NavigationPath
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.productName)]

    var body: some View {
        
        ProductList(searchString: searchText, sortOrder: sortOrder)
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
            let newInventory = Inventory(product: newProduct, qtyInStock: 0)
            let newPrice = Price(netPrice: 0, product: newProduct)
            
            context.insert(newInventory)
            context.insert(newPrice)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            path.append(newProduct)
        }
    }
}
//
//#Preview {
//    
//    ProductTabView(path: "producto")
//        .modelContainer(for: Product.self, inMemory: true)
//}
