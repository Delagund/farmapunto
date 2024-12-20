//
//  TestData.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import Foundation

let testProduct1 = Product(code: "7800060005723",
                           productName: "AB antiséptico x 12 comprimidos",
                           genericName: "Clorhexidina",
                           dosisQty: 12.0,
                           farmaForm: "Comprimidos",
                           laboratoryName: "Saval"
                    )

let inventory = Inventory(product: testProduct1, qtyInStock: 100)
 
//MARK: funcion para borrar en cascada un producto y todos sus datos en otras tablas.

/*
func deleteProduct(_ product: Product, context: ModelContext) throws {
    // Eliminar inventario relacionado
    if let inventory = product.inventory {
        context.delete(inventory)
    }
    
    // Eliminar movimientos relacionados
    for movement in product.movements {
        context.delete(movement)
    }
    
    // Finalmente, eliminar el producto
    context.delete(product)
}
*/
