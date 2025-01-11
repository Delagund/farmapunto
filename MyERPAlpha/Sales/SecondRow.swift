// Segunda fila del punto de Venta: Subtotal

import SwiftUI

struct SecondRow: View {
    @Binding var product: [Product]
    let selectedProducts: Product
    let indexNumber: Int
    @Binding var saleAmount: Int
    
    var body: some View {
        GridRow {
            // SKU
            Text("SKU: \(selectedProducts.code)")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            //Subtotal
            HStack(spacing: 15) {
                Text("Subtotal:")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 16, design: .rounded))
                Text("$\(String(format: "%.0f", selectedProducts.currentPrice * Double(saleAmount)))")
                
                // Botón de eliminación
                Button(action: {
                    product.remove(at: indexNumber)
                    print(indexNumber)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .gridCellColumns(2)
            .gridCellAnchor(UnitPoint(x: 0.9, y: 0.75))
        }
    }
}

#Preview {
    @Previewable @State var products = SampleProducts.contents
    @Previewable @State var index = 0
    @Previewable @State var amount = 2
    SecondRow(product: $products, selectedProducts: products[0] , indexNumber: index, saleAmount: $amount)
}
