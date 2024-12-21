// Vista de estado del stock con indicador visual
struct StockStatusView: View {
    let qtyInStock: Int
    
    var statusColor: Color {
        switch qtyInStock {
            case 0: return .red
            case 1...10: return .orange
            default: return .green
        }
    }
    
    var body: some View {
        Label(
            "\(qtyInStock) en stock",
            systemImage: qtyInStock == 0 ? "exclamationmark.triangle.fill" : "cube.box.fill"
        )
        .foregroundColor(statusColor)
    }
}
