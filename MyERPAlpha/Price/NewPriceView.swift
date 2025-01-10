import SwiftUI

struct NewPriceView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let price: Price
    
    @State private var netPrice: Double = 0.0
    @State private var taxFee: Double = 19.0 //TODO: asignarlo a futuro a una configuracion global
    @State private var revenue: Double = 20.0
    @State private var storedFinalPrice: Double = 0.0
    @State var date: Date = .now
    
    // Calculamos el precio base (costo + margen de ganancia)
    var basePrice: Double {
        let marginAmount = netPrice * (revenue / 100)
        return netPrice + marginAmount
    }
    
    //Precio final redondeado
    private var finalPrice: Double {
        let taxRate = taxFee / 100
        let taxAmount = basePrice * taxRate // Calculamos el impuesto
        let calculedPrice = basePrice + taxAmount

        return calculedPrice.rounded(.toNearestOrAwayFromZero)
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section("Detalle Precios") {
                    HStack(spacing: 15) {
                        DatePicker("Fecha", selection: $date, in: .now...)
                            .keyboardType(.numberPad)
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
        guard netPrice >= 0 else {
            print("Error: El precio neto no puede ser negativo.")
            return
        }
        
        guard taxFee >= 0 else {
            print("Error: El impuesto debe estar entre 0 y 100.")
            return
        }
        
        // Actualización de las propiedades de la transacción
        price.netPrice = netPrice
        price.taxFee = taxFee
        price.revenue = revenue
        price.date = date
        price.storedFinalPrice = finalPrice
        price.product?.currentPrice = finalPrice
        
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
    NewPriceView(price: transactionTest1, date: .now)
}
