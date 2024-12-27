//
//  PriceMaintainerDetailView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 25-12-24.
//

import SwiftUI
import SwiftData

//Vista del mantenedor de precios.
struct PriceMantainerDetailView: View {
    @Environment(\.modelContext) private var context
    let transaction: Transaction
    @State private var showTransactionSheet = false
 
    
    var body: some View {
        List {
            Section("Detalle Producto") {
                LabeledContent("Código (SKU)", value: transaction.product.code)
                
                LabeledContent("Nombre Comercial", value: transaction.product.productName)
                
                LabeledContent("Forma Farmacéutica", value: transaction.product.farmaForm)
                
                LabeledContent("Laboratorio", value: transaction.product.laboratoryName)
            }
            
            Section("Costos") {
                LabeledContent("Costo Neto") { Text("$\(transaction.netPrice, specifier: "%.0f")")
                }
                
                LabeledContent("Ganancia") { Text("\(transaction.revenue, specifier: "%.0f")%")
                }
                
                LabeledContent("Impuesto (IVA)") { Text("\(transaction.taxFee, specifier: "%.0f")%")
                }
            }
            
//            Section("Precio Venta Actual") {
//                LabeledContent("Precio Venta") { Text("$\(transaction.storedFinalPrice)")
//                }
//            }
        }
        .navigationTitle("Mantenedor Precios")
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
