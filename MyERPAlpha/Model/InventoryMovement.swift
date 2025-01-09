//
//  InventoryMovement.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 14-12-24.
//

import Foundation
import SwiftData

@Model
class InventoryMovement {
    @Attribute(.unique) var id: UUID

    var quantity: Int       // unidades del inventario involucradas en el movimientos
    var type: MovementType  // tipo de movimiento de inventario
    var reason: String      // Descripción detallada que se puede escribir para explicar el movimmiento
    var date: Date          // Fecha en que se realiza el movimiento.
    
    init(id: UUID = UUID(), quantity: Int = 0, type: MovementType = MovementType.entrada, reason: String = "", date: Date = Date()) {
        self.id = id
        self.quantity = quantity
        self.type = type
        self.reason = reason
        self.date = date
    }
    
    enum MovementType: Int, Identifiable, Codable, CaseIterable {
        case entrada, salida
        var id: Self {
            self
        }
        var description: String {
            switch self {
                case .entrada:
                    "Entrada"
                case .salida:
                    "Salida"
            }
        }
    }
}

