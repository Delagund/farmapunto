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
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Product.productName)]

    var body: some View {
        NavigationStack(path: $path) {
            ProductView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Productos")
                .navigationDestination(for: Product.self) { product in
                    EditProductView(product: product)
                }
                .toolbar {
                    Menu("Orden", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Nombre A-Z")
                                .tag([SortDescriptor(\Product.productName)])
                            
                            Text("Nombre Z-A")
                                .tag([SortDescriptor(\Product.productName, order: .reverse)])
                        }
                    }
                    Button(action: addItem) {
                        Label("Add Product", systemImage: "plus")
                    }
                }
                .searchable(text: $searchText)
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
