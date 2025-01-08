import SwiftUI
import SwiftData

struct PriceMantainerListView: View {
    @Environment(\.modelContext) private var context
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Price.product.productName)]
    
    var body: some View {
        
        PriceMantainerView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Mantenedor Precios")
            .navigationDestination(for: Price.self) { price in
                PriceMantainerDetailView(price: price)
            }
            .toolbar {
                Menu("Orden", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Nombre A-Z")
                            .tag([SortDescriptor(\Price.product.productName)])
                        
                        Text("Nombre Z-A")
                            .tag([SortDescriptor(\Price.product.productName, order: .reverse)])
                    }
                }
            }
            .searchable(text: $searchText)
    }
}

#Preview {
    PriceMantainerListView()
}
