//
//  Transactions.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 14-12-24.
//

import Foundation
import SwiftData

@Model
class Transaction {
    @Relationship var product: Product
    ///Datos fijos
    var netPrice: Double // precio de costo o valor neto
    var taxFee: Double // porcentaje de impuesto (IVA)
    var discount: Double // porcentaje de descuento sobre precio final (ej: 20%)
    var revenue: Double // porcentaje margen de ganacia sobre valor neto (ej: 35%)
    
    var date: Date // fecha de la transaccion
    
    var storedFinalPrice: Double //para pesistir el dato de precio final de venta
    
    init(product: Product, netPrice: Double = 0, taxFee: Double = 19, discount: Double = 0, revenue: Double = 20 ,date: Date = Date(), storedFinalPrice: Double = 0) {
        self.product = product
        self.netPrice = netPrice
        self.taxFee = taxFee
        self.discount = discount
        self.revenue = revenue
        self.date = date
        self.storedFinalPrice = storedFinalPrice
    }

}
