import SwiftUI
import SwiftData

//Vista del mantenedor de precios.
struct PriceMantainerDetailView: View {
    @Bindable var transaction: Transaction
    @State private var showTransactionSheet = false
    
    var body: some View {
        List {
            // Sección de datos de producto
            Section("Detalle Producto") {
                LabeledContent("Código (SKU)", value: transaction.product.code)
                
                LabeledContent("Nombre Comercial", value: transaction.product.productName)
                
                LabeledContent("Forma Farmacéutica", value: transaction.product.farmaForm)
                
                LabeledContent("Laboratorio", value: transaction.product.laboratoryName)
            }
                // Sección de costos, margen e impuestos
            Section("Costos") {
                LabeledContent("Costo Neto") { Text("$\(transaction.netPrice, specifier: "%.0f")")
                }
                
                LabeledContent("Margen") { Text("\(transaction.revenue, specifier: "%.0f")%")
                }
                
                LabeledContent("Impuesto (IVA)") { Text("\(transaction.taxFee, specifier: "%.0f")%")
                }
            }
            
            Section("Precio Venta Actual") {
                LabeledContent("Precio Venta") { Text("$\(transaction.storedFinalPrice, specifier: "%.0f")")
                }
            }
        }
        .navigationTitle("Editar Precio")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showTransactionSheet = true
                }) {
                    Label("Cambio Precio", systemImage: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showTransactionSheet) {
            NewTransactionView(transaction: transaction, date: Date())
        }
    }
}

#Preview {
    PriceMantainerDetailView(transaction: transactionTest1)
        .modelContainer(for: Transaction.self, inMemory: true)
}
