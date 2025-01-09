// Vista para mostrar una fila de movimiento de inventario

import SwiftUI

struct InventoryMovementRow: View {
    let movement: InventoryMovement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: movement.type == .entrada ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                    .foregroundColor(movement.type == .entrada ? .green : .red)
                
                Text(movement.type.description)
                    .font(.headline)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(movement.quantity) unidades")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movement.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            if !movement.reason.isEmpty {
                Text(movement.reason)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    InventoryMovementRow(movement: inventoryMoves1)
}

