// Vista para ingresar compras de productos

import SwiftUI
import SwiftData

struct PurchasesView: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @State private var purchasedQty: Int = 1 // Cantidad para vender
    @State private var selectedProducts: [Product] = [] // Productos seleccionados para la venta
    @State private var salesModel = SalesModel() //logica de ventas
    @State private var documentNumber = "" // numero de boleta
    @State private var cost: Double = 0 // precio de producto
    @State private var datePurchase = Date() // fecha de transaccion (venta)
    
    var columns: [GridItem] = [
        GridItem(.fixed(140), alignment: .leading),
        GridItem(.fixed(90), alignment: .leading),
        GridItem(.fixed(100), alignment: .leading)
    ]
    
    var body: some View {
        VStack{
            Text("Ingreso de Compras")
                .font(.largeTitle)
                .bold()
            VStack {
                HStack {
                    Text("Ingrese Nº Documento: ")
                    TextField("Nº Documento", text: $documentNumber)
                        .padding(4)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.black.opacity(0.06))
                        }
                }
                DatePicker("Fecha de Ingreso", selection: $datePurchase)
                    .datePickerStyle(.compact)
                
            }
            .padding()
        }
        /// Barra de búsqueda
        ProductSearchBar(products: products, selectedProducts: $selectedProducts, salesModel: salesModel)
        
        /// Vista de productos seleccionados
        LazyVGrid(columns: columns) {
            Text("Producto").bold()
            Text("Cantidad").bold()
            Text("Costo ($)").bold()
            
        }
        .frame(maxWidth: .infinity)
        
        // Filas dinámicas
        ScrollView {
            if !selectedProducts.isEmpty {
                ForEach($selectedProducts.indices, id: \.self) { index in
                    Grid(horizontalSpacing: 5) {
                        // Primera fila: Producto, Cantidad y Precio
                        GridRow(alignment: .center) {
                            // Producto
                            Text(selectedProducts[index].name)
                                .lineLimit(2)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.leading)
                                .gridColumnAlignment(.leading)
                                .frame(width: 140, alignment: .leading)
                            
                            // Cantidad a comprar
                            TextField("Cantidad", value: $purchasedQty, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .frame(width: 90)
                            
                            
                            // Costo unitario neto
                            TextField("Costo Neto", value: $cost, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 90)
                            
                            // Botón Eliminación
                            Button(action: {
                                selectedProducts.remove(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.background
                                .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)))
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("Agregue un producto")
            }
        }
        .toolbar {
            Button(action: savePurchase) {
                Label("Grabar", systemImage: "square.and.arrow.down.fill")
            }
            
        }
        Spacer()
    }
    
    /// Guardar productos comprados.
    private func savePurchase() {
        for index in selectedProducts.indices {
            let product = selectedProducts[index]  // Define producto
            let amountPurchased = purchasedQty // cantidad ingresada
            
            // Crear el registro de movimiento de inventario
            let movement = InventoryMovement(
                quantity: amountPurchased,
                type: .entrada,
                reason: "Compra - Factura Nº \(documentNumber)",
                date: Date()
            )
            
            // Actualizar la cantidad en stock
            product.stockQuantity += movement.quantity
            print(product.stockQuantity) // imprime cantidad en inventario.
            
            // guarda `movement` en la base de datos
            product.movements.append(movement)
            try? context.save()
            
            print("Movimiento registrado: \(movement.id) para \(product.name)")
        }
        
        // Limpiar lista de productos en venta
        selectedProducts = []
    }
}

#Preview {
    PurchasesView()
        .modelContainer(previewContainer)
}
