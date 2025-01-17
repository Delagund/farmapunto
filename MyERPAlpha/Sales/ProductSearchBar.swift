//Barra de busqueda para los productos de la venta
import SwiftUI
import SwiftData

struct ProductSearchBar: View {
    let products: [Product] // Productos disponibles para buscar
    @Binding var selectedProducts: [Product] // Productos seleccionados
    @ObservedObject var salesModel: SalesModel
    @State private var searchQuery: String = ""
    @State private var isDropdownVisible: Bool = false
    
    var body: some View {
        VStack {
            // TextField para la búsqueda
            TextField("Buscar por nombre o SKU", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.background
                            .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)))
                }
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
                                    salesModel.saleAmounts[product.code] = 1
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
    
    /// Productos filtrados por nombre o código
    private var filteredResults: [Product] {
        guard !searchQuery.isEmpty else { return [] }
        return products.filter { product in
           ( product.name.localizedCaseInsensitiveContains(searchQuery) ||
             product.code.localizedCaseInsensitiveContains(searchQuery)) && product.stockQuantity > 0
        }
    }
    
    /// Agregar un producto a la selección
    private func addProductToSelection(_ product: Product) {
        if !selectedProducts.contains(where: { $0.id == product.id }) {
            selectedProducts.append(product)
        }
        searchQuery = ""
        isDropdownVisible = false
    }
}


#Preview("Barra de Búsqueda con Datos de Prueba") {
    @Previewable var salesModel = SalesModel()
    ProductSearchBar(
        products: SampleProducts.contents, // Simulación de consulta
        selectedProducts: .constant([]), // Lista inicial vacía
        salesModel: salesModel // instancia de salesModel, para agregar cantidad de elementos en venta.
    )
        .modelContainer(previewContainer)
}
