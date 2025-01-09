// Vista para mostrar una fila de cambios de precio

import SwiftUI

struct PriceMovementRow: View {
    let price: Price
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                Text(price.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                VStack {
                    HStack{
                        Text("Costo: $\(price.netPrice, specifier: "%.1f")")
                        
                        Text("Margen:\(price.revenue, specifier: "%.1f")%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Precio Venta: $\(price.storedFinalPrice, specifier: "%.0f")")
                }
            }
        }
    }
}

#Preview {
    PriceMovementRow(price: transactionTest1)
}
