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
    var netPrice: Double
    var taxFee: Double // porcentaje de impuesto (IVA)
    var discount: Double // porcentaje
    var finalPrice: Double {
        return netPrice - (netPrice * discount / 100) //TODO: revisar esta formula para plantear correctamente la formulacion del precio final
    }
    
    var date: Date
    
    init(product: Product, netPrice: Double, taxFee: Double, discount: Double, date: Date = Date()) {
        self.product = product
        self.netPrice = netPrice
        self.taxFee = taxFee
        self.discount = discount
        self.date = date
    }

}
