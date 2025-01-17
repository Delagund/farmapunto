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
        GridItem(.flexible(minimum: 10, maximum: .infinity))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                // Encabezado Punto de Venta
                HeaderView(saleNumber: $saleNumber)
                
                // Barra de búsqueda para agregar productos
                ProductSearchBar(products: products, selectedProducts: $selectedProducts, salesModel: salesModel)
            
                Divider()
                // Encabezados de las columnas
                
                LazyVGrid(columns: columns) {
                    Text("Producto").bold()
                    Text("Precio").bold()
                    Text("Cantidad").bold()
                }
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.background
                            .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)))
                }
               
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
                                      indexNumber: index)

                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.background
                                    .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)))
                        }
                    }
                } else {
                    Text("Agregue un producto")
                }
                
                //Vista de Totales, items, IVA, efectivo, vuelto
                TotalsView(salesModel: salesModel,
                           selectedProducts: $selectedProducts,
                           cashMoney: $cashMoney)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.background
                            .shadow(.drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)))
                }
                
                //Botones de cancelar y Terminar Venta
                EndingSale(selectedProducts: $selectedProducts,
                           salesModel: salesModel,
                           cashMoney: $cashMoney,
                           saleNumber: $saleNumber)
                .padding(.top)
            }
        }
    }
}


#Preview {
    PointOfSaleView()
        .modelContainer(previewContainer)
}

