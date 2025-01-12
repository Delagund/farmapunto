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
                            FirstRow(salesModel: salesModel,
                                     selectedProduct: selectedProducts[index],
                                     indexNumber: index
                            )
                            
                            // Segunda fila: SKU, subtotal, boton eliminar
                            SecondRow(salesModel: salesModel, selectedProducts: $selectedProducts, selectedProduct: selectedProducts[index], indexNumber: index
                            )

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
                TotalsView(salesModel: salesModel, selectedProducts: $selectedProducts, cashMoney: $cashMoney)
                
                // Botones de cancelacion o cierre de venta
                HStack {
                    // Botón "Cancelar"
                    Button(action: {
                        cashMoney = 0
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
                        completeSale()
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
        for index in selectedProducts.indices {
            let product = selectedProducts[index]
            let saleAmount = salesModel.saleAmounts[product.code]
            
            guard saleAmount != nil else { print("cantidad invalidad")
                return}
            
        // Crear el registro de movimiento de inventario
            let movement = InventoryMovement(
                quantity: saleAmount ?? 0,
                type: .salida,
                reason: "Venta Nº XXXX", //TODO: ajustar a numero de venta de la cabecera.
                date: Date()
            )
            
            // Actualizar la cantidad en stock
            product.stockQuantity -= movement.quantity
            
            // guarda `movement` en la base de datos
            product.movements.append(movement)
            try? context.save()
            
            print("Movimiento registrado: \(movement.id) para \(product)")
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

