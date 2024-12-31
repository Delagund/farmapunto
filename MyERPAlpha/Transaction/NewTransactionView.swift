import SwiftUI

struct NewTransactionView: View {
    let transaction: Transaction
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var netPrice: Double = 0.0
    @State private var taxFee: Double = 0.0
    @State private var revenue: Double = 0.0
    @State private var storedFinalPrice: Double = 0.0
    @State var date: Date = .now
    
    //Precio neto (sin impuestos)
    private var totalPrice: Double {
        return netPrice / (100 - revenue) * 100
    }
    
    //Precio final redondeado
    private var finalPrice: Double {
        var calculedPrice = totalPrice
        calculedPrice += (calculedPrice * (taxFee / 100))
        return calculedPrice.rounded(.toNearestOrAwayFromZero)
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section("Detalle Precios") {
                    HStack(spacing: 15) {
                        DatePicker("Fecha", selection: $date, in: .now...)
                            .keyboardType(.numberPad)
                            .foregroundColor(.secondary)
                    }
                    HStack(spacing: 15) {
                        Text("Precio Costo:")
                        TextField("Valor", value: $netPrice, format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 15) {
                        Text("Impuestos (%):")
                        TextField("IVA (%)", value: $taxFee, format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 15) {
                        Text("Margen (%):")
                        TextField("Porcentaje", value: $revenue, format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(.secondary)
                    }
                }
                Section("Precio Resultante") {
                    LabeledContent("Precio de Venta Público", value: finalPrice, format: .currency(code: "CLP"))
                }
            }
            .navigationTitle("Cambio Precio")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        saveNewPrice()
                    }
                }
            }
        }
    }
    
    private func saveNewPrice() {
        // Validación básica de los datos
        guard netPrice > 0 else {
            print("Error: El precio neto debe ser mayor que 0.")
            return
        }
        
        guard taxFee >= 0 && taxFee <= 100 else {
            print("Error: El impuesto debe estar entre 0 y 100.")
            return
        }
        
        guard revenue >= 0 && revenue <= 100 else {
            print("Error: El margen debe estar entre 0 y 100.")
            return
        }
        
        // Actualización de las propiedades de la transacción
        transaction.netPrice = netPrice
        transaction.taxFee = taxFee
        transaction.revenue = revenue
        transaction.date = date
        transaction.storedFinalPrice = finalPrice
        
        // Guardar los cambios en el contexto
        do {
            try context.save()
            dismiss() // Cerrar la vista después de guardar
        } catch {
            print("Error al guardar la transacción: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    NewTransactionView(transaction: transactionTest1, date: .now)
}
