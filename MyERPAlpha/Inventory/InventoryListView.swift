import SwiftUI
import SwiftData

///Vista de listado de productos con su stock disponible. Incluye búsqueda y filtro de orden alfabético
struct InventoryListView: View {
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.name)]
    
    var body: some View {
       
        InventoryList(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Inventario")
            .navigationDestination(for: Product.self) { product in
                InventoryDetailView(product: product)
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
            }
            .searchable(text: $searchText)
    }
}

#Preview {
    InventoryListView()
        .modelContainer(previewContainer)
}
