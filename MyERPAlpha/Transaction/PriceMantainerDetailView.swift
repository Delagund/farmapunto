//
//  PriceMaintainerDetailView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 25-12-24.
//

import SwiftUI
import SwiftData

struct PriceMantainerDetailView: View {
    @Environment(\.modelContext) private var context
    let transaction: Transaction
    
    var body: some View {
        Form {
            Section("Detalle Producto") {
                LabeledContent("Código (SKU)", value: transaction.product.code)
                
                LabeledContent("Nombre Comercial", value: transaction.product.productName)
            }
        }
    }
}

#Preview {
    PriceMantainerDetailView(transaction: transactionTest1)
        .modelContainer(for: Transaction.self, inMemory: true)
}
