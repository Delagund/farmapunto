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
    @State private var path = [Product]()


    var body: some View {
        NavigationStack(path: $path) {
            ProductView()
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
            let newProduct = Product(code: "001", productName: "PRODUCTO")
            context.insert(newProduct)
            path.append(newProduct)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
