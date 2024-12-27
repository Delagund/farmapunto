//
//  NewTransactionView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 26-12-24.
//

import SwiftUI

struct NewTransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let transaction: Transaction
    
    @State private var netPrice: Double = 0.0
    @State private var taxFee: Double = 0.0
    @State private var revenue: Double = 0.0
    @State private var storedFinalPrice: Double = 0
    @State var date: Date
    
    //Precio neto (sin impuestos)
    private var totalPrice: Double {
        return netPrice / (100 - revenue) * 100
    }
    
    var body: some View {
        Form{
            Section("Detalle Precios") {
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

                }
            }
        }
    }
    
    private func saveNewPrice() {
        
        var calculedPrice = totalPrice
        calculedPrice += (calculedPrice * (taxFee / 100))
        transaction.storedFinalPrice =  calculedPrice.rounded(.toNearestOrAwayFromZero)
        
    }
}

#Preview {
    NewTransactionView(transaction: transactionTest1, date: .now)
}
