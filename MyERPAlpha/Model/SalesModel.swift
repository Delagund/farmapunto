//Modelo para la lógica del punto de venta. enfoque centralizado para que los datos de las vistas del punto de venta se rellenen con estos valores

import SwiftUI

class SalesModel: ObservableObject {
    @Published var saleAmounts: [Int: Int] = [:] // Diccionario para almacenar la cantidad de cada producto según su índice
    
    func subtotal(for product: Product, at index: Int) -> Double {
        let quantity = saleAmounts[index] ?? 1
        return Double(quantity) * product.currentPrice
    }
    
    func total(for products: [Product]) -> Double {
        products.indices.reduce(0) { total, index in
            total + subtotal(for: products[index], at: index)
        }
    }
    
    func resetSaleAmounts() {
        saleAmounts = [:]
    }
}

