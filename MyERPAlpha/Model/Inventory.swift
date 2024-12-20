//
//  Inventory.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 14-12-24.
// Creacion de modelo para manejar inventario de productos.
import Foundation
import SwiftData

@Model
class Inventory {
    @Relationship var product: Product
    var qtyInStock: Int                 // cantidad en inventario
    var movements: [InventoryMovement]  // historial de movimientos asociados al producto.
    
    init(product: Product, qtyInStock: Int = 0) {
        self.product = product
        self.qtyInStock = qtyInStock
        self.movements = []
    }
    
    /// Actualiza el stock basado en un movimiento.
    func updateStock(movement: InventoryMovement) {
        movements.append(movement)
        switch movement.type {
            case .entrada:
                qtyInStock += movement.quantity
            case .salida:
                qtyInStock -= movement.quantity
        }
    }
    
    /// Método para validar si hay suficiente stock antes de realizar una salida (opcional).
    func hasSufficientStock(for quantity: Int) -> Bool {
        return qtyInStock - quantity >= 0
    }
}

