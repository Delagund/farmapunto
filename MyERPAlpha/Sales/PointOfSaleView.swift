import SwiftUI
import SwiftData

struct PointOfSaleView: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @State private var saleNumber = 1 //TODO: Falta persistir este dato.
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
                HeaderView(saleNumber: $saleNumber)
                
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
                            SecondRow(salesModel: salesModel,
                                      selectedProducts: $selectedProducts,
                                      selectedProduct: selectedProducts[index],
                                      indexNumber: index
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
                TotalsView(salesModel: salesModel,
                           selectedProducts: $selectedProducts,
                           cashMoney: $cashMoney)
                
                EndingSale(selectedProducts: $selectedProducts,
                           salesModel: $salesModel,
                           cashMoney: $cashMoney,
                           saleNumber: $saleNumber)
            }
        }
    }
}


#Preview {
    PointOfSaleView()
        .modelContainer(previewContainer)
}

