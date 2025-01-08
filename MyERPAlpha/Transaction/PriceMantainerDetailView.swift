import SwiftUI
import SwiftData

//Vista del mantenedor de precios.
struct PriceMantainerDetailView: View {
    @Bindable var price: Price
    @State private var showPriceSheet = false
    
    var body: some View {
        List {
            // Sección de datos de producto
            Section("Detalle Producto") {
                LabeledContent("Código (SKU)", value: price.product.code)
                
                LabeledContent("Nombre Comercial", value: price.product.productName)
                
                LabeledContent("Forma Farmacéutica", value: price.product.farmaForm)
                
                LabeledContent("Laboratorio", value: price.product.laboratoryName)
            }
                // Sección de costos, margen e impuestos
            Section("Costos") {
                LabeledContent("Costo Neto") { Text("$\(price.netPrice, specifier: "%.0f")")
                }
                
                LabeledContent("Margen") { Text("\(price.revenue, specifier: "%.0f")%")
                }
                
                LabeledContent("Impuesto (IVA)") { Text("\(price.taxFee, specifier: "%.0f")%")
                }
            }
            
            Section("Precio Venta Actual") {
                LabeledContent("Precio Venta") { Text("$\(price.storedFinalPrice, specifier: "%.0f")")
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
            NewPriceView(price: price, date: Date())
        }
    }
}

#Preview {
    PriceMantainerDetailView(price: transactionTest1)
        .modelContainer(for: Price.self, inMemory: true)
}
