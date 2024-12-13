//
//  Product.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import Foundation
import SwiftData

@Model
final class Product {
    var code: String
    var productName: String
    var genericName: String
    var dosisQty: Double
    var farmaForm: String
    var laboratoryName: String
    
    init(code: String = "", productName: String = "", genericName: String = "", dosisQty: Double = 1.0, farmaForm: String = "", laboratoryName: String = "") {
        self.code = code
        self.productName = productName
        self.genericName = genericName
        self.dosisQty = dosisQty
        self.farmaForm = farmaForm
        self.laboratoryName = laboratoryName
    }
}
