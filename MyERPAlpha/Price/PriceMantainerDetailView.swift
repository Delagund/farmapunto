import SwiftUI
import SwiftData

//Vista del mantenedor de precios.
struct PriceMantainerDetailView: View {
    @Bindable var product: Product
    @State private var showPriceSheet = false
    
    @State private var netPrice: Double = 0.0
    @State private var revenue: Double = 0.0
    @State private var taxFee: Double = 19.0
    @State private var finalPrice: Double = 0.0
    
    var sortedPrices: [Price] {
        product.price.sorted { $0.date > $1.date}
    }
    
    var body: some View {
        List {
            // Sección de datos de producto
            Section("Detalle Producto") {
                LabeledContent("Código (SKU)", value: product.code)
                
                LabeledContent("Nombre Comercial", value: product.name)
                
                LabeledContent("Forma Farmacéutica", value: product.dosageForm.rawValue)
                
                LabeledContent("Laboratorio", value: product.laboratoryName)
            }
            // Sección de precio de venta a público.
            Section("Precio Venta Actual") {
                LabeledContent("Precio Venta") { Text("$\(product.currentPrice, specifier: "%.0f")")
                }
            }
            
            // Sección de movimientos de inventario
            Section("Historial de Movimientos") {
                if sortedPrices.isEmpty {
                    Text("No hay movimientos registrados")
                        .foregroundColor(.secondary)
                        .italic()
                } else {
                    ForEach(sortedPrices, id: \.date) { price in
                        PriceMovementRow(price: price)
                    }
                }
            }
        }
        .navigationTitle("Editar Precio")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showPriceSheet = true
                }) {
                    Label("Cambio Precio", systemImage: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showPriceSheet) {
            let price = Price(product: product)
            NewPriceView(price: price)
        }
    }
}

#Preview {
    PriceMantainerDetailView(product: testProduct1)
        .modelContainer(for: Price.self, inMemory: true)
        
}
