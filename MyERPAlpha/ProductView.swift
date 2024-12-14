//
//  ProductView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI
import SwiftData

struct ProductView: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
    var body: some View {
        List {
            ForEach(products) { product in
                NavigationLink(value: product) {
                    VStack(alignment: .leading) {
                        Text(product.productName)
                        HStack{
                            Text("SKU:")
                            Text(product.code)
                                .font(.system(size: 10))
                                .fontWeight(.light)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let product = products[offset]
                context.delete(product)
            }
        }
    }
}

#Preview {
    ProductView()
}
