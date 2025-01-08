//
//  PriceHistorial.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 08-01-25.
//

import Foundation
import SwiftData

final class PriceHistorial {
    
    @Attribute(.unique) var id: UUID
    @Relationship var product: Product
    
    var netPrice: Double // precio de costo o valor neto
    var revenue: Double // porcentaje margen de ganacia sobre valor neto (ej: 35%)
    var date: Date // fecha de la transaccion
    var storedFinalPrice: Double // para pesistir el dato de precio final de venta
    
    init(id: UUID = UUID(), product: Product, netPrice: Double, revenue: Double, date: Date, storedFinalPrice: Double) {
        self.id = id
        self.product = product
        self.netPrice = netPrice
        self.revenue = revenue
        self.date = date
        self.storedFinalPrice = storedFinalPrice
    }
}
