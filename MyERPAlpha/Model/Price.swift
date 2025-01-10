import Foundation
import SwiftData

@Model
class Price {
    var netPrice: Double // precio de costo o valor neto
    var taxFee: Double // porcentaje de impuesto (IVA)
    var revenue: Double // porcentaje margen de ganacia sobre valor neto (ej: 35%)
    @Attribute(.unique) var date: Date // fecha de la transaccion
    
    var storedFinalPrice: Double // para pesistir el dato de precio final de venta
    
    @Relationship(inverse: \Product.price) var product: Product?
    
    init(netPrice: Double = 0.0, taxFee: Double = 19, revenue: Double = 20 ,date: Date = Date(), storedFinalPrice: Double = 0.0, product: Product? = nil) {
        self.netPrice = max(0.0, netPrice) // Asegura que no sea negativo
        self.taxFee = max(0.0, taxFee)
        self.revenue = max(0.0, revenue)
        self.date = date
        self.storedFinalPrice = max(0.0, storedFinalPrice)
        self.product = product
    }

}
