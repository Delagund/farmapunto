import SwiftUI
import SwiftData

// Vista principal para mostrar el inventario.
struct InventoryDetailView: View {
    @Bindable var product: Product
    @State private var showingMovementSheet = false
    
    // Ordenamos los movimientos por fecha, más reciente primero
    var sortedMovements: [InventoryMovement] {
        product.movements.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        List {
            // Sección de información del producto farmacéutico
            Section("Stock en Inventario") {
                LabeledContent("Código (SKU)", value: product.code)
                
                LabeledContent("Nombre Comercial", value: product.name)
                
                LabeledContent("Forma Farmacéutica", value: product.dosageForm.rawValue)
                
                LabeledContent("Laboratorio", value: product.laboratoryName)
                
                LabeledContent("Stock Actual") {
                    Text("\(product.stockQuantity) unidades")
                        .foregroundColor(product.stockQuantity < 10 ? .red : .secondary)
                }
            }
            
            // Sección de movimientos de inventario
            Section("Historial de Movimientos") {
                if sortedMovements.isEmpty {
                    Text("No hay movimientos registrados")
                        .foregroundColor(.secondary)
                        .italic()
                } else {
                    ForEach(sortedMovements, id: \.date) { movement in
                        InventoryMovementRow(movement: movement)
                    }
                }
            }
        }
        .navigationTitle("\(product.name)")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showingMovementSheet = true
                }) {
                    Label("Nuevo Movimiento", systemImage: "plus.circle")
                }
            }
            
            ToolbarItem(placement: .status) {
                StockStatusView(qtyInStock: product.stockQuantity)
            }
        }
        .sheet(isPresented: $showingMovementSheet) {
            NewInventoryMovementView(product: product)
        }
    }
}

#Preview {
    InventoryDetailView(product: testProduct1)
        .modelContainer(for: Product.self, inMemory: true)
}
