
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

let transactionTest1 = Price(netPrice: 1200, taxFee: 19, revenue: 20, storedFinalPrice: 2500, product: testProduct1)

let testProduct2 = Product(code: "78123000234",
                           productName: "CLORFENAMINA 4MG X 20 COMP",
                           genericName: "CLORFENAMINA",
                           dosisQty: 12.0,
                           farmaForm: "COMPRIMIDOS",
                           laboratoryName: "LAB. CHILE"
                    )
let inventoryTest2 = Inventory(product: testProduct2, qtyInStock: 298)
let inventoryMoves2 = InventoryMovement(product: testProduct2, quantity: 35, type: .entrada, reason: "compra", date: .now)

let transactionTest2 = Price(netPrice: 180, taxFee: 19, revenue: 20, storedFinalPrice: 990, product: testProduct2)

let myTestProducts = [testProduct1, testProduct2]
let myInventoriesTest = [inventoryTest1, inventoryTest2]
 
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
 
 //MARK: Variables para calculos de precio
 
 //Precio neto (sin impuestos)
 var totalPrice: Double {
 return netPrice / (100 - revenue) * 100
 }
 
 private var finalPrice: Double {
 var calculedPrice = totalPrice
 calculedPrice += (calculedPrice * (taxFee / 100))
 if discount > 0 {
 calculedPrice -= (calculedPrice * discount / 100)
 }
 return calculedPrice.rounded(.toNearestOrAwayFromZero)
 }
 
 
 /// Actualiza el stock basado en un movimiento.
 func updateStock(movement: InventoryMovement) {
 movements.append(movement)
 switch movement.type {
 case .entrada:
 qtyInStock += movement.quantity
 case .salida:
 qtyInStock -= movement.quantity
 }
 }
 
 /// Método para validar si hay suficiente stock antes de realizar una salida (opcional).
 func hasSufficientStock(for quantity: Int) -> Bool {
 return qtyInStock - quantity >= 0
 }
 
 
*/
