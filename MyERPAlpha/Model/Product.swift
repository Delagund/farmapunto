
/// Objeto producto farmaceutico. Clase principal.

import Foundation
import SwiftData

@Model
class Product {
    
    @Attribute(.unique) var code: String    // SKU o código interno único
    
    var productName: String // nombre de fantasia o comercial.
    var genericName: String // nombre principio activo.
    var dosisQty: Double    // cantidad de dosis por caja, ej: número de pastillas o gramos o ml por envase.
    var farmaForm: String   // forma farmaceutica, ej: comprimdos, jarabe, etc.
    var laboratoryName: String // nombre fabricante
    
    @Relationship(deleteRule: .cascade, inverse: \Inventory.product) var inventory: [Inventory]
    @Relationship(deleteRule: .cascade, inverse: \InventoryMovement.product) var movements: [InventoryMovement]
    @Relationship(deleteRule: .cascade, inverse: \Price.product) var price: [Price]

    init(code: String = "", productName: String = "", genericName: String = "", dosisQty: Double = 0.0, farmaForm: String = "", laboratoryName: String = "", inventory: [Inventory] = [], movements: [InventoryMovement] = [], price: [Price] = []) {
        self.code = code
        self.productName = productName
        self.genericName = genericName
        self.dosisQty = dosisQty
        self.farmaForm = farmaForm
        self.laboratoryName = laboratoryName
        self.inventory = inventory
        self.movements = movements
        self.price = price
    }
}
