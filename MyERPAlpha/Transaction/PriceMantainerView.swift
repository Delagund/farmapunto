import SwiftUI
import SwiftData

struct PriceMantainerView: View {
    @Environment(\.modelContext) private var context
    @Query var transactions: [Transaction]
    
    var body: some View {
        Group{
            if transactions.isEmpty {
                ContentUnavailableView("Crea un Producto para Empezar", systemImage: "pills.fill")
            } else {
//TODO: cambiar a LAzyVGrid para evitar que se carguen muchos datos de una sola vez
                List {
                    ForEach(transactions) { transaction in
                        NavigationLink(value: transaction) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text("SKU:\(transaction.product.code)")
                                    Text(transaction.product.productName)
                                        .fontWeight(.semibold)
                                }
                                .font(.caption2)
                                
                                Spacer()
                                HStack{
                                    Text("Precio: $")
                                    Text("\(transaction.storedFinalPrice, specifier: "%.0f")")
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
    init(searchString: String = "", sortOrder: [SortDescriptor<Transaction>] = []) {
        _transactions = Query(filter: #Predicate { transaction in
            if searchString.isEmpty {
                true
            } else {
                transaction.product.productName.localizedStandardContains(searchString)
                || transaction.product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }

}

#Preview {
    PriceMantainerView()
}
