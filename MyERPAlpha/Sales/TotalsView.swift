// Fila de Totales de productos para venta

import SwiftUI

struct TotalsView: View {
    @Binding var selectedProducts: [Product]
    @Binding var cashMoney: Double
    var quantity: Double = 1.0
    
    var subtotal: Double {
        selectedProducts.reduce(0) {$0 + ($1.currentPrice * quantity) - ($1.currentPrice * quantity * 0.19)}
    }
    
    var fee: Double {
        selectedProducts.reduce(0) {$0 + (($1.currentPrice * quantity * 0.19))} // 19% de impuesto
    }
    
    var total: Double {
        selectedProducts.reduce(0) { $0 + ($1.currentPrice * quantity) }
    }
    
//    var itemsQty: Int {
//        selectedProducts.reduce(0) { $0 + $1.quantity }
//    }
    var itemsQty = 1
    
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
                    Text("$\(String(format: "%.0f", total))")
                }
                .font(.system(size: 25, design: .rounded))
                .bold()
            }
            HStack {
                Spacer()
                Text("IVA en esta compra (19%):")
                Text("$\(String(format: "%.0f", fee))")
            }
            .font(.system(size: 15, design: .rounded))
            .foregroundStyle(.secondary)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Efectivo: ")
                TextField("Valor", value: $cashMoney, format: .number)
                    .frame(width: 70)
                    .background(Color.gray.opacity(0.3))
                    .padding(5)
                Text("Vuelto: $\(String(format: "%.0f", vuelto))")
            }
            .fontWeight(.medium)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var productsTest = SampleProducts.contents
    @Previewable @State var cash = 10000.0
    TotalsView(selectedProducts: $productsTest, cashMoney: $cash)
}
