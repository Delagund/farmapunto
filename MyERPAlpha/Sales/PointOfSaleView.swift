import SwiftUI
import SwiftData

struct PointOfSaleView: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
    @State private var selectedProducts: [Product] = [] // Productos seleccionados para la venta
    
    @State private var salesModel = SalesModel()
    @State private var cashMoney: Double = 0.0
    
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity), alignment: .leading)
        
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                // Encabezado Punto de Venta
                HeaderView()
                
                // Barra de búsqueda para agregar productos
                ProductSearchBar(products: products, selectedProducts: $selectedProducts)
            
                Divider()
                // Encabezados de las columnas
                
                LazyVGrid(columns: columns) {
                    Text("Producto").bold()
                    Text("Precio").bold()
                    Text("Cantidad").bold()
                }
                .frame(maxWidth: .infinity)
                
                // Filas dinámicas
                if !selectedProducts.isEmpty {
                    ForEach($selectedProducts.indices, id: \.self) { index in
                        Grid(horizontalSpacing: 5) {
                            // Primera fila: Producto, Cantidad y Precio
                            FirstRow(salesModel: salesModel, selectedProducts: selectedProducts[index], indexNumber: index)
                            
                            // Segunda fila: SKU, subtotal, boton eliminar
                            SecondRow(salesModel: salesModel, products: $selectedProducts, selectedProduct: selectedProducts[index], indexNumber: index)

                            // Tercera fila: linea division entre productos.
                            GridRow {
                                Divider()
                                    .gridCellColumns(3)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    Text("Agregue un producto")
                }
                //Vista de Totales, items, IVA, efectivo, vuelto
                TotalsView(selectedProducts: $selectedProducts, cashMoney: $cashMoney)
                
                // Botones de cancelacion o cierre de venta
                HStack {
                    // Botón "Cancelar"
                    Button(action: {
                        salesModel.resetSaleAmounts()
                        selectedProducts = []
                    }) {
                        Text("Cancelar")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(maxWidth: 150) // Tamaño más pequeño
                    
                    // Botón "Terminar Venta"
                    Button(action: {
                        //TODO: implmentar logica
                    }) {
                        Text("Terminar Venta")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func completeSale() {
        for index in products.indices {
            let product = products[index]
            let saleAmount = salesModel.saleAmounts[index]
            
//            // Actualizar el stock del producto
//            products[index].stock -= saleAmount
            
            // Crear el registro de movimiento de inventario
            let movement = InventoryMovement(
                quantity: saleAmount!,
                type: .salida,
                reason: "Venta de producto",
                date: Date()
            )
            
            // Aquí puedes guardar `movement` en la base de datos o manejarlo según sea necesario
            print("Movimiento registrado: \(movement)")
        }
        
        // Limpiar las cantidades en venta
        salesModel.resetSaleAmounts()
        
        // Limpiar lista de productos en venta
        selectedProducts = []
    }
}


#Preview {
    PointOfSaleView()
        .modelContainer(previewContainer)
}

