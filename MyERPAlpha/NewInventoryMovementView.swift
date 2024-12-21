// Vista para crear un nuevo movimiento de inventario
struct NewInventoryMovementView: View {
    let inventory: Inventory
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var movementType: InventoryMovement.MovementType = .entrada
    @State private var quantity: Int = 1
    @State private var reason: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // Constantes para validación
    private let maxQuantityPerMovement = 1000
    
    var body: some View {
        NavigationView {
            Form {
                Section("Producto") {
                    LabeledContent("Código", value: inventory.product.code)
                    LabeledContent("Nombre", value: inventory.product.productName)
                    LabeledContent("Presentación", value: inventory.product.farmaForm)
                }
                
                Section("Detalles del Movimiento") {
                    Picker("Tipo de Movimiento", selection: $movementType) {
                        ForEach(InventoryMovement.MovementType.allCases) { type in
                            Text(type.description).tag(type)
                        }
                    }
                    
                    Stepper(value: $quantity, in: 1...maxQuantityPerMovement) {
                        HStack {
                            Text("Cantidad:")
                            Spacer()
                            Text("\(quantity) unidades")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("Motivo del Movimiento") {
                    TextEditor(text: $reason)
                        .frame(height: 100)
                }
                
                Section("Información de Stock") {
                    LabeledContent("Stock Actual", value: "\(inventory.qtyInStock)")
                    
                    if movementType == .salida {
                        LabeledContent("Stock Resultante") {
                            Text("\(max(0, inventory.qtyInStock - quantity))")
                                .foregroundColor(inventory.qtyInStock - quantity < 0 ? .red : .secondary)
                        }
                    }
                }
            }
            .navigationTitle("Nuevo Movimiento")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        validateAndSave()
                    }
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func validateAndSave() {
        // Validaciones
        if reason.isEmpty {
            alertMessage = "Por favor, ingrese un motivo para el movimiento"
            showingAlert = true
            return
        }
        
        if movementType == .salida && quantity > inventory.qtyInStock {
            alertMessage = "Stock insuficiente para realizar esta salida"
            showingAlert = true
            return
        }
        
        // Crear el nuevo movimiento
        let movement = InventoryMovement(
            product: inventory.product,
            quantity: quantity,
            type: movementType,
            reason: reason
        )
        
        // Actualizar la cantidad en stock
        if movementType == .entrada {
            inventory.qtyInStock += quantity
        } else {
            inventory.qtyInStock -= quantity
        }
        
        // Actualizar las relaciones bidireccionales
        inventory.movements.append(movement)
        inventory.product.movements?.append(movement)
        
        // Guardar los cambios en SwiftData
        try? modelContext.save()
        
        dismiss()
    }
}
