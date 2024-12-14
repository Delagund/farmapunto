//
//  Product.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import Foundation
import SwiftData

@Model
class Product {
    var code: String
    var productName: String
    var genericName: String
    var dosisQty: Double
    var farmaForm: String
    var laboratoryName: String
    var qtyInStock: Int
    var netPrice: Double
    var finalPrice: Double
    
    init(code: String = "", productName: String = "", genericName: String = "", dosisQty: Double = 0.0, farmaForm: String = "", laboratoryName: String = "", qtyInStock: Int = 0, netPrice: Double = 0.0, finalPrice: Double = 0.0) {
        self.code = code
        self.productName = productName
        self.genericName = genericName
        self.dosisQty = dosisQty
        self.farmaForm = farmaForm
        self.laboratoryName = laboratoryName
        self.qtyInStock = qtyInStock
        self.netPrice = netPrice
        self.finalPrice = finalPrice
    }
    
    
}
