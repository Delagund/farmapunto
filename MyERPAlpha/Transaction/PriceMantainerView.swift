//
//  PriceMaintainer.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 25-12-24.
// vista de lista de precios por producto (orden: nombre A-Z)

import SwiftUI
import SwiftData

struct PriceMantainerView: View {
    
    @Environment(\.modelContext) private var context
    @Query var transactions: [Transaction]
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                NavigationLink(value: transaction) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("SKU:\(transaction.product.code)")
                            Text(transaction.product.productName)
                        }
                        .font(.caption2)
                        .fontWeight(.semibold)
                        Spacer()
                        HStack{
                            Text("Precio: $")
                            Text("\(transaction.finalPrice)")
                        }
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.medium)
                        
                    }
                }
            }
        }
    }
    
    //inicializador de la busqueda y orden
    init(searchString: String = "", sortOrder: [SortDescriptor<Transaction>] = []) {
        _transactions = Query(filter: #Predicate { transaction in
            if searchString.isEmpty {
                true
            } else {
                transaction.product.productName.localizedStandardContains(searchString)
                || transaction.product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }

}

#Preview {
    PriceMantainerView()
}
