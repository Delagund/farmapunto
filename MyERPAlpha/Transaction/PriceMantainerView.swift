import SwiftUI
import SwiftData

struct PriceMantainerView: View {
   
    @Query var prices: [Price]
    
    var body: some View {
        Group{
            if prices.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
//TODO: cambiar a LAzyVGrid para evitar que se carguen muchos datos de una sola vez
                List {
                    ForEach(prices) { price in
                        NavigationLink(value: price) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text("SKU:\(price.product.code)")
                                    Text(price.product.productName)
                                        .fontWeight(.semibold)
                                }
                                .font(.caption2)
                                
                                Spacer()
                                HStack{
                                    Text("Precio: $")
                                    Text("\(price.storedFinalPrice, specifier: "%.0f")")
                                }
                                .font(.system(size: 18, design: .rounded))
                                .fontWeight(.medium)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //inicializador de la busqueda y orden
    init(searchString: String = "", sortOrder: [SortDescriptor<Price>] = []) {
        _prices = Query(filter: #Predicate { price in
            if searchString.isEmpty {
                true
            } else {
                price.product.productName.localizedStandardContains(searchString)
                || price.product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }

}

#Preview {
    PriceMantainerView()
}
