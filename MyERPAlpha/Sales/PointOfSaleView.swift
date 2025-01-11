import SwiftUI
import SwiftData

struct PointOfSaleView: View {
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    @State private var selectedProducts: [Product] = [] // Productos seleccionados para la venta
    @State private var saleAmount: Int = 1
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
                            FirstRow(selectedProducts: selectedProducts[index], indexNumber: index, saleAmount: saleAmount)
                            // Segunda fila: SKU, subtotal, boton eliminar
                            SecondRow(product: $selectedProducts, selectedProducts: selectedProducts[index], indexNumber: index, saleAmount: $saleAmount)
                            
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
                TotalsView(selectedProducts: $selectedProducts, cashMoney: $cashMoney, quantity: Double(saleAmount), itemsQty: saleAmount)
            }
        }
    }
}


#Preview {
    PointOfSaleView()
        .modelContainer(previewContainer)
}

