import SwiftUI
import SwiftData

struct PriceMantainerTabView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Query var transactions: [Transaction]
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Transaction.product.productName)]
    
    var body: some View {
        
        PriceMantainerView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Mantenedor Precios")
            .navigationDestination(for: Transaction.self) { transaction in
                PriceMantainerDetailView(transaction: transaction)
            }
            .toolbar {
                Menu("Orden", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Nombre A-Z")
                            .tag([SortDescriptor(\Transaction.product.productName)])
                        
                        Text("Nombre Z-A")
                            .tag([SortDescriptor(\Transaction.product.productName, order: .reverse)])
                    }
                }
            }
            .searchable(text: $searchText)
    }
}

#Preview {
    PriceMantainerTabView()
}
