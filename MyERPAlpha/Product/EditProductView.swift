//Vista de edición de producto.

import SwiftUI
import SwiftData

struct EditProductView: View {
    @Bindable var product: Product
    @State private var formType: Product.FormType = .comprimidos
    
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
                TextField("Producto", text: $product.name, axis: .horizontal)
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
                Picker("Presentación:", selection: $formType) {
                    ForEach(Product.FormType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle()) //TODO: Revisar
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
