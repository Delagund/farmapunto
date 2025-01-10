import SwiftUI
import SwiftData

struct PriceView: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
    var body: some View {
        Group{
            if products.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
//TODO: cambiar a LazyVGrid para evitar que se carguen muchos datos de una sola vez
                List {
                    ForEach(products) { product in
                        NavigationLink(value: product) {
                            HStack(spacing: 5) {
                                VStack(alignment: .leading) {
                                    Text("SKU:\(product.code)")
                                    Text(product.name)
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                }
                                .frame(width: 190, alignment: .leading)
                                .font(.caption2)
                                
                                HStack(alignment: .lastTextBaseline){
                                    Text("Precio Venta: $ \(product.currentPrice, specifier: "%.0f")")
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

}

#Preview {
    PriceView()
        .modelContainer(previewContainer)
}
