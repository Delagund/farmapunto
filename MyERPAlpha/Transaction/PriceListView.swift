import SwiftUI
import SwiftData

struct PriceListView: View {
    //TODO: eliminar -> @Environment(\.modelContext) private var context
    
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.name)]
    
    var body: some View {
        
        PriceView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Mantenedor Precios")
            .navigationDestination(for: Product.self) { product in
                PriceMantainerDetailView(product: product)
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
    PriceListView()
}
