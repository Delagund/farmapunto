
// Creacion de modelo para manejar inventario de productos.
import Foundation
import SwiftData

@Model
class Inventory {
    @Relationship(inverse: \Product.inventory) var product: Product?
    
    var quantity: Int                 // cantidad en inventario
    var movements: [InventoryMovement]  // historial de movimientos asociados al producto.
    
    init(product: Product? = nil , quantity: Int = 0, movements: [InventoryMovement] = [] ) {
        self.product = product
        self.quantity = quantity
        self.movements = movements
    }
}

