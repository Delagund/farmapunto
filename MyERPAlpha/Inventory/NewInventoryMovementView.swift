import SwiftUI

// Vista para crear un nuevo movimiento de inventario
struct NewInventoryMovementView: View {
    @Bindable var product: Product
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var movementType: InventoryMovement.MovementType = .entrada
    @State private var quantity: Int = 0
    @State private var reason: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Producto") {
                    LabeledContent("Código", value: product.code)
                    LabeledContent("Nombre", value: product.name)
                    LabeledContent("Presentación", value: product.dosageForm.rawValue)
                }
                
                Section("Detalles del Movimiento") {
                    Picker("Tipo de Movimiento", selection: $movementType) {
                        ForEach(InventoryMovement.MovementType.allCases) { type in
                            Text(type.description).tag(type)
                        }
                    }
                    
                    HStack() {
                        Text("Cantidad:")
                        TextField("Cantidad", value: $quantity, format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(.secondary)
                    }
    
                }
                
                Section("Motivo del Movimiento") {
                    TextEditor(text: $reason)
                        .frame(height: 100)
                }
                
                Section("Información de Stock") {
                    LabeledContent("Stock Actual", value: "\(product.stockQuantity)")
                    
                    if movementType == .salida {
                        LabeledContent("Stock Resultante") {
                            Text("\(max(0, product.stockQuantity - quantity))")
                                .foregroundColor(product.stockQuantity - quantity < 0 ? .red : .secondary)
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
        
        if movementType == .salida && quantity > product.stockQuantity {
            alertMessage = "Stock insuficiente para realizar esta salida"
            showingAlert = true
            return
        }
        
        // Crear el nuevo movimiento
        let movement = InventoryMovement(
            quantity: quantity,
            type: movementType,
            reason: reason
        )
        
        // Actualizar la cantidad en stock
        if movementType == .entrada {
            product.stockQuantity += movement.quantity
        } else {
            product.stockQuantity -= movement.quantity
        }
        
        // Actualizar las relaciones bidireccionales
        product.movements.append(movement)
        
        // Guardar los cambios en SwiftData
        try? context.save()
        
        dismiss()
    }
}

#Preview {
    NewInventoryMovementView(product: testProduct1)
}
