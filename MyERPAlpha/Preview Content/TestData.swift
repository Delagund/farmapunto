
import Foundation

let testProduct1 = Product(code: "7800060005723",
                           name: "AB ANTISEPTICO x 12 COMP",
                           genericName: "CLORHEXIDINA",
                           dosisQty: 12.0,
                           dosageForm: .comprimidos,
                           laboratoryName: "SAVAL",
                           currentPrice: 2490,
                           stockQuantity: 12,
                           createdAt: .now,
                           updateAt: Date(timeIntervalSinceNow: 12000),
                           inventory: [
                            Inventory(quantity: 12,
                                      movements: [
                                InventoryMovement(quantity: 5, type: .salida, reason: "venta", date: Date(timeIntervalSinceNow: 86400)),
                                InventoryMovement(quantity:17, type: .entrada, reason: "Compra", date: .now)
                            ])
                           ],
                           price: [
                            Price(netPrice: 1600, taxFee: 19, revenue: 50, date: .now, storedFinalPrice: 2490),
                            Price(netPrice: 1590, taxFee: 19, revenue: 50, date: Date(timeIntervalSinceNow: 86400), storedFinalPrice: 2400)
                           ]
                    )

let inventoryTest1 = Inventory(product: testProduct1, quantity: 345)

let inventoryMoves1 = InventoryMovement(quantity: 11, type: .salida, reason: "venta", date: .now)

let transactionTest1 = Price(netPrice: 1200, taxFee: 19, revenue: 20, storedFinalPrice: 2500)

let testProduct2 = Product(code: "78123000234",
                           name: "CLORFENAMINA 4MG X 20 COMP",
                           genericName: "CLORFENAMINA",
                           dosisQty: 12.0,
                           dosageForm: .crema,
                           laboratoryName: "LAB. CHILE"
                    )
let inventoryTest2 = Inventory(product: testProduct2, quantity: 298)
let inventoryMoves2 = InventoryMovement(quantity: 35, type: .entrada, reason: "compra", date: .now)

let transactionTest2 = Price(netPrice: 180, taxFee: 19, revenue: 20, storedFinalPrice: 990, product: testProduct2)

let myTestProducts = [testProduct1, testProduct2]
let myInventoriesTest = [inventoryTest1, inventoryTest2]
 
struct SampleProducts {
    static var contents: [Product] = [
        Product(code: "7800060005723",
                name: "AB ANTISEPTICO x 12 COMP",
                genericName: "CLORHEXIDINA",
                dosisQty: 12.0,
                dosageForm: .comprimidos,
                laboratoryName: "SAVAL",
                currentPrice: 2490,
                stockQuantity: 12,
                createdAt: .now,
                updateAt: Date(timeIntervalSinceNow: 12000),
                inventory: [
                    Inventory(quantity: 12, movements: [
                        InventoryMovement(quantity: 5, type: .salida, reason: "venta", date: Date(timeIntervalSinceNow: 86400)),
                        InventoryMovement(quantity:17, type: .entrada, reason: "Compra", date: .now)
                    ])
                ],
                price: [
                    Price(netPrice: 1600, taxFee: 19, revenue: 50, date: .now, storedFinalPrice: 2490)
                ]
               ),
        Product(code: "7834006780515",
                name: "PARACETAMOL 500MG X 16 COMP",
                genericName: "PARACETAMOL",
                dosisQty: 16.0,
                dosageForm: .comprimidos,
                laboratoryName: "LAB. CHILE",
                currentPrice: 990,
                stockQuantity: 23,
                createdAt: .now,
                updateAt: Date(timeIntervalSinceNow: 432000),
                inventory: [
                    Inventory(quantity: 23, movements: [
                        InventoryMovement(quantity: 13, type: .entrada, reason: "COMPRA", date: .now)
                    ])
                ],
                price: [
                    Price(netPrice: 189, taxFee: 19, revenue: 80, date: .now, storedFinalPrice: 990)
                    ]
               ),
        Product(code: "2301759204987",
                name: "PYRIPED SUSP X 100 ML",
                genericName: "IBUPROFENO",
                dosisQty: 120,
                dosageForm: .suspension,
                laboratoryName: "PRATER",
                currentPrice: 4990,
                stockQuantity: 11,
                createdAt: .now,
                updateAt: Date(timeIntervalSinceNow: 86400),
                inventory: [
                    Inventory(quantity: 6, movements: [
                        InventoryMovement(quantity: 10, type: .entrada, reason: "COMPRA", date: .now)
                    ])
                ],
                price: [
                    Price(netPrice: 1290, taxFee: 19, revenue: 40, date: .now, storedFinalPrice: 4990)
                ]
               )
    ]
}


/*
 
 
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
