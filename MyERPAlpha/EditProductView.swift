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
                    .keyboardType(.numberPad)
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
                Text("Dosis x Envase:")
                    .bold()
                TextField("Cantidad de dosis", value: $product.dosisQty, format: .number)
                    .keyboardType(.numberPad)
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
            
        }
        .navigationTitle("Editar Producto")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    EditProductView(product: testProduct1)
}
