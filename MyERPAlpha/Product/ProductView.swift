import SwiftUI
import SwiftData

/// Vista de lista de productos
struct ProductView: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
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
                                Text(product.productName)
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
                    .onDelete(perform: deleteItems)
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
                product.productName.localizedStandardContains(searchString)
                || product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
//TODO: revisar este método para poder borrar correctamente unn porducto y sus relaciones
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let product = products[offset]
                context.delete(product)
            }
        }
    }
}

#Preview {
    ProductView()
        
}
