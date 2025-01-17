//
//  EndingSale.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 16-01-25.
//

import SwiftUI

struct EndingSale: View {
    @Environment(\.modelContext) private var context
    @Binding var selectedProducts: [Product] // Productos seleccionados para la venta
    @ObservedObject var salesModel: SalesModel
    @Binding var cashMoney: Double
    @Binding var saleNumber: Int
    
    var body: some View {
        
        // Botones de cancelacion o cierre de venta
        HStack {
            // Botón "Cancelar"
            Button(action: {
                cashMoney = 0
                salesModel.resetSaleAmounts()
                selectedProducts = []
            }) {
                Text("Cancelar")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(maxWidth: 120) // Tamaño más pequeño
            
            // Botón "Terminar Venta"
            Button(action: {
                completeSale()
            }) {
                Text("Terminar Venta")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(.horizontal)
    }
    
    private func completeSale() {
        for index in selectedProducts.indices {
            let product = selectedProducts[index]  // Define producto
            let saleAmount = salesModel.saleAmounts[product.code] ?? 1 // cantidad en venta
            
            // Crear el registro de movimiento de inventario
            let movement = InventoryMovement(
                quantity: saleAmount,
                type: .salida,
                reason: "Venta Nº \(saleNumber)",
                date: Date()
            )
            
            // Actualizar la cantidad en stock
            product.stockQuantity -= movement.quantity
            print(product.stockQuantity)
            
            // guarda `movement` en la base de datos
            product.movements.append(movement)
            try? context.save()
            
            print("Movimiento registrado: \(movement.id) para \(product.name)")
        }
        
        // Limpiar las cantidades en venta
        salesModel.resetSaleAmounts()
        
        // Limpiar lista de productos en venta
        selectedProducts = []
        
        // Cambiar número de la venta
        saleNumber += 1
    }
}

#Preview {
    @Previewable @State var products = SampleProducts.contents
    @Previewable var salesModel = SalesModel()
    @Previewable @State var cash: Double = 20000
    @Previewable @State var saleNumber: Int = 2
    EndingSale(selectedProducts: $products, salesModel: salesModel, cashMoney: $cash, saleNumber: $saleNumber)
        .modelContainer(previewContainer)
}
