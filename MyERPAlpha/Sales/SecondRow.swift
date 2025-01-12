// Segunda fila del punto de Venta: Subtotal

import SwiftUI

struct SecondRow: View {
    @ObservedObject var salesModel: SalesModel //manejo de lógica de venta
    @Binding var products: [Product]
    let selectedProduct: Product
    let indexNumber: Int
   
    
    var body: some View {
        GridRow {
            // SKU
            Text("SKU: \(selectedProduct.code)")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            //Subtotal - usando la lógica centralizada.
            HStack(spacing: 15) {
                Text("Subtotal:")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 16, design: .rounded))
                Text("$\(String(format: "%.0f", salesModel.subtotal(for: selectedProduct, at: indexNumber)))")
                
                // Botón de eliminación que usa datos de logica de venta
                Button(action: {
                    salesModel.saleAmounts[indexNumber] = nil // Eliminar la cantidad para este índice
                    products.remove(at: indexNumber)
                    print("Eliminado producto en índice \(indexNumber)")
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
    @Previewable var salesModel = SalesModel()
    SecondRow(salesModel: salesModel, products: $products, selectedProduct: products[0] , indexNumber: index)
}
