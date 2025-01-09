
/// Objeto producto farmaceutico. Clase principal.

import Foundation
import SwiftData

@Model
class Product {
    //listado de formas farmacéuticas
    enum FormType: String, Codable, CaseIterable {
        case comprimidos = "Comprimidos"
        case capsulas = "Capsulas"
        case solucion = "Solucion Oral"
        case inyectable = "inyectable"
        case colirio = "Solución Oftalmica"
        case sachet = "Sachet"
        case crema = "Crema"
        case unguento = "Unguento"
        case parche = "Parche"
        case locion = "Locion"
        case suspension = "Suspension Oral"
        case shampoo = "Shampoo"
        case unknown = "Desconocido"
    }
    
    @Attribute(.unique) var code: String    // SKU o código interno único
    
    var name: String // nombre de fantasia o comercial.
    var genericName: String // nombre principio activo.
    var dosisQty: Double    // cantidad de dosis por caja, ej: número de pastillas o gramos o ml por envase.
    var dosageForm: FormType   // forma farmaceutica, ej: comprimdos, jarabe, etc.
    var laboratoryName: String // nombre fabricante
    var currentPrice: Double // Precio de venta
    var stockQuantity: Int // cantidad de inventario
    var createdAt: Date
    var updateAt: Date
    
    //Relaciones entre modelos
    @Relationship(deleteRule: .cascade) var inventory: [Inventory]
    @Relationship(deleteRule: .cascade) var movements: [InventoryMovement]
    @Relationship(deleteRule: .cascade) var price: [Price]

    init(code: String = "", name: String = "", genericName: String = "", dosisQty: Double = 0.0, dosageForm: FormType = .comprimidos, laboratoryName: String = "", currentPrice: Double = 0.0,stockQuantity: Int = 0, createdAt: Date = .now, updateAt: Date = Date(), inventory: [Inventory] = [], movements: [InventoryMovement] = [], price: [Price] = []) {
        self.code = code
        self.name = name
        self.genericName = genericName
        self.dosisQty = dosisQty
        self.dosageForm = dosageForm
        self.laboratoryName = laboratoryName
        self.currentPrice = currentPrice
        self.stockQuantity = stockQuantity
        self.createdAt = createdAt
        self.updateAt = updateAt
        self.inventory = inventory
        self.movements = movements
        self.price = price
    }
}
