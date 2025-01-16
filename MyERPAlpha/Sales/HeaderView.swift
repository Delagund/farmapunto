
// Título de la vista Punto de Venta.

import SwiftUI

struct HeaderView: View {
    @Binding var saleNumber: Int
    var dateOfSale: String = Date().formatted(date: .abbreviated, time: .shortened)
    
    var body: some View {
        Text("Punto de Venta")
            .font(.largeTitle)
            .bold()
            .padding()
        
        // Informacion de número de transacion y fecha TODO: ver como persistir data.
        HStack{
            Text("Venta Nº: \(saleNumber)")
            Spacer()
            Text("Fecha: \(dateOfSale)")
                .font(.system(size: 13))
        }
        .padding(.horizontal)
    }
}
        
