//
//  EditProductView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI
import SwiftData

struct EditProductView: View {
    @Bindable var product: Product
    
    var body: some View {
        
        Form {
            HStack(alignment: .center) {
                Text("SKU:")
                    .bold()
                TextField("Código de Barras", text: $product.code)
            }
            HStack(alignment: .center) {
                Text("Nombre:")
                    .bold()
                TextField("Producto", text: $product.productName, axis: .horizontal)
                    .textInputAutocapitalization(.characters)
            }
            HStack(alignment: .center) {
                Text("Nombre Genérico:")
                    .bold()
                TextField("Principio Activo", text: $product.genericName)
                    .textInputAutocapitalization(.characters)
            }
            HStack(alignment: .center) {
                Text("Dosis unitaria:")
                    .bold()
                TextField("Cantidad de dosis", value: $product.dosisQty, format: .number)
            }
            HStack(alignment: .center) {
                Text("Presentación:")
                    .bold()
                TextField("Forma Farmacéuticas", text: $product.farmaForm)
                    .textInputAutocapitalization(.characters)
            }
            HStack(alignment: .center) {
                Text("Laboratorio:")
                    .bold()
                TextField("Laboratorio", text: $product.laboratoryName)
                    .textInputAutocapitalization(.characters)
            }
            HStack(alignment: .center) {
                Text("Stock:")
                    .bold()
                TextField("en Inventario", value: $product.qtyInStock, format: .number)
            }
            HStack(alignment: .center) {
                Text("Costo Neto: $")
                    .bold()
                TextField("Valor Neto", value: $product.netPrice, format: .number)
            }
            HStack(alignment: .center) {
                Text("Precio Venta: $")
                    .bold()
                TextField("Valor $", value: $product.finalPrice, format: .number)
            }
        }
        .navigationTitle("Editar Producto")
        .navigationBarTitleDisplayMode(.automatic)
        
    }
}

#Preview {
    EditProductView(product: testProduct1)
}
