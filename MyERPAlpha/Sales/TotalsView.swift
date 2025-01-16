// Fila de Totales de productos para venta

import SwiftUI

struct TotalsView: View {
    @ObservedObject var salesModel: SalesModel
    @Binding var selectedProducts: [Product]
    @Binding var cashMoney: Double
   
    /// Precio de Venta antes de impuestos.
    var subtotal: Double {
        selectedProducts.reduce(0) { total, product in
            let quantity = salesModel.saleAmounts[product.code] ?? 1
            return total + (product.currentPrice * Double(quantity))
        } * 0.81
    }
    /// impuesto (IVA 19%)
    var fee: Double {
        selectedProducts.reduce(0) { total, product in
            let quantity = salesModel.saleAmounts[product.code] ?? 1
            return total + (product.currentPrice * Double(quantity))
        } * 0.19
    }
    
    /// Precio de venta con impuesto
    var total: Double {
        subtotal + fee
    }
    /// Suma todas las cantidades elegidas
    var itemsQty: Int {
        salesModel.saleAmounts.values.reduce(0, +)
    }
    /// calcular vuelto en efectivo
    var vuelto: Double {
        let result = cashMoney - total
        if result <= 0 { return 0.0
        } else {
            return result
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            HStack(alignment: .center){
                HStack{
                    Text("Items:")
                    Text("\(itemsQty) un.")
                }
                .font(.system(size: 15, design: .rounded))
                .foregroundStyle(.secondary)
                Spacer()
                HStack {
                    Text("Total:")
                    Text("$ \(String(format: "%.0f", total))")
                }
                .font(.system(size: 25, design: .rounded))
                .bold()
            }
            HStack {
                Spacer()
                Text("IVA en esta compra (19%):")
                Text("$ \(String(format: "%.0f", fee))")
            }
            .font(.system(size: 15, design: .rounded))
            .foregroundStyle(.secondary)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Efectivo: $")
                TextField("Valor", value: $cashMoney, format: .number)
                    .frame(width: 70)
                    .background(Color.gray.opacity(0.3))
                    .padding(.trailing, 5)
                Text("Vuelto: $ \(String(format: "%.0f", vuelto))")
            }
            .fontWeight(.medium)
        }
        .padding()
    }
}

#Preview {
    @Previewable var salesModel = SalesModel()
    @Previewable @State var productsTest = SampleProducts.contents
    @Previewable @State var cash = 20000.0
    TotalsView(salesModel: salesModel, selectedProducts: $productsTest, cashMoney: $cash)
}
