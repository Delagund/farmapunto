import SwiftUI
import SwiftData

///Vista de lista de producto por stock
struct InventoryList: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
    var body: some View {
        Group{
            if products.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
//TODO: cambiar a lazyVGrid para evitar que se carguen muchos datos de una sola vez
                List {
                    ForEach(products, id: \.code) { product in
                        NavigationLink(value: product) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading){
                                    Text("SKU: \(product.code)")
                                    Text(product.name)
                                        .fontWeight(.semibold)
                                }
                                .font(.caption2)
                                
                                HStack{
                                    Spacer()
                                    LabeledContent("Stock Actual:", value: "\(product.stockQuantity) un.")
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
    InventoryList()
}
