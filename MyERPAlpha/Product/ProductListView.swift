import SwiftUI
import SwiftData

///vista de productos - con creacion de nuevo producto - búsqueda y filtro alfabetico.
struct ProductListView: View {
    @Environment(\.modelContext) private var context
    
    @Binding var path: NavigationPath
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.name)]

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
                            .tag([SortDescriptor(\Product.name)])
                        
                        Text("Nombre Z-A")
                            .tag([SortDescriptor(\Product.name, order: .reverse)])
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
            let newProduct = Product(code: "", name: "PRODUCTO")
            
            context.insert(newProduct)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            path.append(newProduct)
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    ProductListView(path: $path)
        .modelContainer(previewContainer)
}
