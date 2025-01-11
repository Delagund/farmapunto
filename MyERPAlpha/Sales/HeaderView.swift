
// Título de la vista Punto de Venta.

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Punto de Venta")
            .font(.largeTitle)
            .bold()
            .padding()
        
        // Informacion de número de transacion y fecha TODO: implementar logica.
        HStack{
            Text("Venta Nº: 123")
            Spacer()
            Text("Fecha: 23/12/2024")
        }
        .padding(.horizontal)
    }
}
        
