//
//  TestData.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import Foundation

let testProduct1 = Product(code: "7800060005723",
                           productName: "AB antiséptico x 12 comprimidos",
                           genericName: "CLORHEXIDINA",
                           dosisQty: 12.0,
                           farmaForm: "COMPRIMIDOS",
                           laboratoryName: "Saval"
                    )

let inventoryTest1 = Inventory(product: testProduct1, qtyInStock: 345)

let inventoryMoves1 = InventoryMovement(product: testProduct1, quantity: 11, type: .salida, reason: "venta", date: .now)

let testProduct2 = Product(code: "78123000234",
                           productName: "CLORFENAMINA 4MG X 20 COMP",
                           genericName: "CLORFENAMINA",
                           dosisQty: 12.0,
                           farmaForm: "COMPRIMIDOS",
                           laboratoryName: "LAB. CHILE"
                    )
let inventoryTest2 = Inventory(product: testProduct2, qtyInStock: 298)
let inentoryMoves2 = InventoryMovement(product: testProduct2, quantity: 35, type: .entrada, reason: "compra", date: .now)

let myTestProducts = [testProduct1, testProduct2]
 
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
 
 
 Text(String(format: "%.2f €", producto.precio))
 .frame(width: 80, alignment: .trailing)
*/
