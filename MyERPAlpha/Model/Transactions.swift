import Foundation
import SwiftData

@Model
class Transaction {
    var id: UUID
    
    @Relationship var product: Product
    
    var netPrice: Double // precio de costo o valor neto
    var taxFee: Double // porcentaje de impuesto (IVA)
    var revenue: Double // porcentaje margen de ganacia sobre valor neto (ej: 35%)
    var date: Date // fecha de la transaccion
    var storedFinalPrice: Double // para pesistir el dato de precio final de venta
    
    init(id: UUID = UUID(), product: Product, netPrice: Double = 0.0, taxFee: Double = 19, revenue: Double = 20 ,date: Date = Date(), storedFinalPrice: Double = 0.0) {
        self.id = id
        self.product = product
        self.netPrice = max(0.0, netPrice) // Asegura que no sea negativo
        self.taxFee = max(0.0, taxFee)
        self.revenue = max(0.0, revenue)
        self.date = date
        self.storedFinalPrice = max(0.0, storedFinalPrice)
    }

}
