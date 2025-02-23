import SwiftUI
import SwiftData

/// Vista de lista de productos
struct ProductList: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    @State private var showDeleteAlert = false
    @State private var selectedOffsets: IndexSet?
    
    var body: some View {
        Group{
            if products.isEmpty {
                ContentUnavailableView("Crea un Producto", systemImage: "pills.fill")
            } else {
//TODO: cambiar formato a lazyVGrid para evitar sobrecarga con listado muy largo.
                List {
                    ForEach(products, id: \.code) { product in
                        NavigationLink(value: product) {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                HStack{
                                    Text("SKU:")
                                    Text(product.code)
                                }
                                .font(.system(size: 15, design: .rounded))
                                .fontWeight(.light)
                            }
                        }
                    }
                    .onDelete{
                        offsets in
                        selectedOffsets = offsets
                        showDeleteAlert = true
                    }
                }
                .alert("Confirmar eliminación", isPresented: $showDeleteAlert) {
                    Button("Cancelar", role: .cancel) {
                        // No se realiza ninguna acción
                    }
                    Button("Eliminar", role: .destructive) {
                        if let offsets = selectedOffsets {
                            deleteItems(at: offsets)
                        }
                    }
                } message: {
                    Text("¿Seguro quiere eliminar este producto? Esta acción NO se puede deshacer")
                }
            }
        }
    }
    
    //inicializador de la busqueda y orden
    init(searchString: String = "", sortOrder: [SortDescriptor<Product>] = []) {
        _products = Query(filter: #Predicate { product in
            if searchString.isEmpty {
                true
            } else {
                product.name.localizedStandardContains(searchString)
                || product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    // borrar elementos al deslizar
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let product = products[offset]
                context.delete(product)
                try? context.save()
            }
        }
    }
}

#Preview {
    ProductList()
        .modelContainer(previewContainer)
        
}
