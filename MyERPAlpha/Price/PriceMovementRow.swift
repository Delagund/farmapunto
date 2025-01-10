// Vista para mostrar una fila de cambios de precio

import SwiftUI

struct PriceMovementRow: View {
    let price: Price
    
    // MARK: - Date Formatter
    static let localizedDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long // Formato local para la fecha
        formatter.timeStyle = .short // Formato local para la hora
        formatter.locale = Locale.current // Usa el idioma y región del dispositivo
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Fecha: \(Self.localizedDateFormatter.string(from: price.date))")
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
