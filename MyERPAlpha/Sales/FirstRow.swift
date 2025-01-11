// Primera fila: Producto, Cantidad y Precio

import SwiftUI


struct FirstRow: View {
    let selectedProducts: Product
    let indexNumber: Int
    @State var saleAmount: Int
    
    var body: some View {
        
         GridRow {
            
            // Producto
            Text(selectedProducts.name)
                .lineLimit(2)
                .minimumScaleFactor(0.2)
                .multilineTextAlignment(.leading)
                .gridColumnAlignment(.leading)
                .frame(width: 140, alignment: .leading)
            
            // Precio unitario
            Text("$\(String(format: "%.0f", selectedProducts.currentPrice))")
                .frame(width: 90)
            
            // Cantidad
            Stepper("\(saleAmount)", value: $saleAmount, in: 1...99)
                .bold()
                .frame(width: 140)
        }
    }
    
}

#Preview {
    @Previewable @State var products = SampleProducts.contents
    @Previewable @State var index = 0
    @Previewable @State var amount = 2
    FirstRow(selectedProducts: products[0] , indexNumber: index, saleAmount: amount)
}
