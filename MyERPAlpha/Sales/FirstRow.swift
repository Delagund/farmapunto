// Primera fila: Producto, Cantidad y Precio

import SwiftUI


struct FirstRow: View {
    @ObservedObject var salesModel: SalesModel  //para manejar los cálculos de la vista
    let selectedProduct: Product
    let indexNumber: Int
    
    var body: some View {
        
         GridRow {
            
            // Producto
            Text(selectedProduct.name)
                .lineLimit(2)
                .minimumScaleFactor(0.2)
                .multilineTextAlignment(.leading)
                .gridColumnAlignment(.leading)
                .frame(width: 140, alignment: .leading)
            
            // Precio unitario
            Text("$\(String(format: "%.0f", selectedProduct.currentPrice))")
                .frame(width: 90)
            
            // Cantidad
             Stepper("\(salesModel.saleAmounts[selectedProduct.code] ?? 1)", value: Binding(
                get: { salesModel.saleAmounts[selectedProduct.code] ?? 1 },
                set: { newValue in
                    salesModel.saleAmounts[selectedProduct.code] = newValue }
             ), in: 1...99)
                .bold()
                .frame(width: 140)
        }
    }
    
}

#Preview {
    @Previewable @State var products = SampleProducts.contents
    @Previewable @State var index = 0
    @Previewable var salesModel = SalesModel()
    FirstRow(salesModel: salesModel, selectedProduct: products[0] , indexNumber: index)
}
