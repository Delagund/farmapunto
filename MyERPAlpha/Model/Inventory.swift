
// Creacion de modelo para manejar inventario de productos.
import Foundation
import SwiftData

@Model
class Inventory {
    @Relationship var product: Product
    
    var qtyInStock: Int                 // cantidad en inventario
    var movements: [InventoryMovement]  // historial de movimientos asociados al producto.
    
    init(product: Product , qtyInStock: Int = 0) {
        self.product = product
        self.qtyInStock = qtyInStock
        self.movements = []
    }
    
    
}

