// Vista para mostrar una fila de cambios de precio

import SwiftUI

struct PriceMovementRow: View {
    let price: Price
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Fecha: \(Date().formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    HStack{
                        Text("Costo: $\(price.netPrice, specifier: "%.0f")")
                        Spacer()
                        Text("Margen: \(price.revenue, specifier: "%.1f")%")
                    }
                    HStack{
                        Text("Precio Venta:")
                        Spacer()
                        Text("$\(price.storedFinalPrice, specifier: "%.0f")")
                    }
                    .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    PriceMovementRow(price: transactionTest1)
}
