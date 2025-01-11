//Barra de busqueda para los productos de la venta
import SwiftUI
import SwiftData

struct ProductSearchBar: View {
    @Environment(\.modelContext) var context
   // @Query var products: [Product] // Productos disponibles para buscar
    var products: [Product] //TODO: Cambiar por variable de arriba para usar la app.
    @Binding var selectedProducts: [Product] // Productos seleccionados
    
    @State private var searchQuery: String = ""
    @State private var isDropdownVisible: Bool = false
    
    var body: some View {
        VStack {
            // TextField para la búsqueda
            TextField("Buscar por nombre o SKU", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: searchQuery, { oldValue, newValue in
                    isDropdownVisible = !searchQuery.isEmpty
                })
            
            // Resultados flotantes
            if isDropdownVisible {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(filteredResults, id: \.id) { product in
                            Text("\(product.name) (\(product.code))")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .onTapGesture {
                                    addProductToSelection(product)
                                }
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding()
            }
        }
        .onTapGesture {
            isDropdownVisible = false // Ocultar resultados al hacer clic fuera
        }
    }
    
    // Productos filtrados por nombre o código
    private var filteredResults: [Product] {
        guard !searchQuery.isEmpty else { return [] }
        return products.filter { product in
            product.name.localizedCaseInsensitiveContains(searchQuery) ||
            product.code.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    // Agregar un producto a la selección
    private func addProductToSelection(_ product: Product) {
        if !selectedProducts.contains(where: { $0.id == product.id }) {
            selectedProducts.append(product)
        }
        searchQuery = ""
        isDropdownVisible = false
    }
}


#Preview("Barra de Búsqueda con Datos de Prueba") {
    ProductSearchBar(
        products: SampleProducts.contents, // Simulación de consulta
        selectedProducts: .constant([]) // Lista inicial vacía
    )
        .modelContainer(previewContainer)
}
