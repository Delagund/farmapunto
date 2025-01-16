///Menú principal de selcción de funciones

import SwiftUI

struct MainMenuApp: View {
    
    @State private var path = NavigationPath() // Ruta global
    
    /// Datos para conformar los botones
    var buttonConfigs: [squareButton] = [
        .init(iconSystemName: "pills.fill", buttonName: "Productos", buttonColor: Color.blue),
        .init(iconSystemName: "pencil.and.list.clipboard", buttonName: "Inventario", buttonColor: Color.red),
        .init(iconSystemName: "dollarsign.square", buttonName: "Mantenedor Precios", buttonColor: Color.orange),
        .init(iconSystemName: "cart.badge.plus", buttonName: "Venta", buttonColor: Color.green),
        .init(iconSystemName: "pencil", buttonName: "Compras", buttonColor: Color.black)
    ]
    
    ///Layout de los butones
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    /// Vista de los botones
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 20) {
                Text("FARMAPUNTO")
                    .font(.system(size: 45, design: .none))
                    .bold()
                    .padding()
                
                HStack {
                    LazyVGrid(columns: columns, spacing: 35) {
                        ForEach(buttonConfigs, id: \.buttonName) { squareOption in
                            squareButton(iconSystemName: squareOption.iconSystemName,
                                         buttonName: squareOption.buttonName,
                                         buttonColor: squareOption.buttonColor)
                            .onTapGesture {
                                path.append(squareOption.buttonName) // Navega a la vista que corresponda
                            }
                        }
                    }
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                            case "Productos":
                                ProductListView(path: $path)
                            case "Inventario":
                                InventoryListView()
                            case "Mantenedor Precios":
                                PriceListView()
                            case "Venta":
                                PointOfSaleView()
                            default:
                                Text("Vista no encontrada")
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MainMenuApp()
        .modelContainer(previewContainer)
}
