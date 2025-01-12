// Primera fila: Producto, Cantidad y Precio

import SwiftUI


struct FirstRow: View {
    @ObservedObject var salesModel: SalesModel  //para manejar los cálculos de la vista
    let selectedProducts: Product
    let indexNumber: Int
    
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
             Stepper("\(salesModel.saleAmounts[indexNumber] ?? 1)", value: Binding(
                get: { salesModel.saleAmounts[indexNumber] ?? 1 },
                set: { salesModel.saleAmounts[indexNumber] = $0 }
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
    FirstRow(salesModel: salesModel, selectedProducts: products[0] , indexNumber: index)
}
