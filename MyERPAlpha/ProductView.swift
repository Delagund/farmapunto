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
        Group{
            if products.isEmpty {
                ContentUnavailableView("Crea un Producto", systemImage: "pills.fill")
            } else {
                List {
                    ForEach(products) { product in
                        NavigationLink(value: product) {
                            VStack(alignment: .leading) {
                                Text(product.productName)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                HStack{
                                    Text("SKU:")
                                    Text(product.code)
                                }
                                .font(.system(size: 15, design: .rounded))
                                .fontWeight(.light)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Product>] = []) {
        _products = Query(filter: #Predicate { product in
            if searchString.isEmpty {
                true
            } else {
                product.productName.localizedStandardContains(searchString)
                || product.code.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
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

//#Preview {
//    ProductView()
//        
//}
