import SwiftUI
import SwiftData

// Vista principal para mostrar el inventario de un producto farmacéutico
struct InventoryDetailView: View {
    let inventory: Inventory
    @Environment(\.modelContext) private var context
    @State private var showingMovementSheet = false
    
    // Ordenamos los movimientos por fecha, más reciente primero
    var sortedMovements: [InventoryMovement] {
        inventory.movements.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        List {
            // Sección de información del producto farmacéutico
            Section("Stock en Inventario") {
                LabeledContent("Código (SKU)", value: inventory.product.code)
                
                LabeledContent("Nombre Comercial", value: inventory.product.productName)
                
                LabeledContent("Principio Activo", value: inventory.product.genericName)
                
                LabeledContent("Forma Farmacéutica", value: inventory.product.farmaForm)
                
                LabeledContent("Dosis por Envase") {
                    Text("\(inventory.product.dosisQty, specifier: "%.2f")")
                }
                
                LabeledContent("Laboratorio", value: inventory.product.laboratoryName)
                
                LabeledContent("Stock Actual") {
                    Text("\(inventory.qtyInStock) unidades")
                        .foregroundColor(inventory.qtyInStock < 10 ? .red : .secondary)
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
        .navigationTitle("\(inventory.product.productName)")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showingMovementSheet = true
                }) {
                    Label("Nuevo Movimiento", systemImage: "plus.circle")
                }
            }
            
            ToolbarItem(placement: .status) {
                StockStatusView(qtyInStock: inventory.qtyInStock)
            }
        }
        .sheet(isPresented: $showingMovementSheet) {
            NewInventoryMovementView(inventory: inventory)
        }
    }
}

#Preview {
    InventoryDetailView(inventory: inventoryTest1)
        .modelContainer(for: Inventory.self, inMemory: true)
}
