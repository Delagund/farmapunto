//
//  ContentView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @State private var path = [Product]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(products) { product in
                    NavigationLink(value: product) {
                        Text(product.productName)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Productos")
            .navigationDestination(for: Product.self
                                   , destination: { product in
                EditProductView(product: product)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Product", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newProduct = Product(productName: "producto")
            context.insert(newProduct)
            path.append(newProduct)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
