//
//  SelectionMenuView.swift
//  ERP2Alpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI

struct MainMenuApp: View {
    
    @State private var path = NavigationPath() // Ruta global
    
    /// Datos para conformar los botones
    var buttonConfigs: [squareButton] = [
        .init(iconSystemName: "pills.fill", buttonName: "Productos", buttonColor: Color.blue),
        .init(iconSystemName: "pencil.and.list.clipboard", buttonName: "Inventario", buttonColor: Color.red),
        .init(iconSystemName: "dollarsign.square", buttonName: "Mantenedor Precios", buttonColor: Color.yellow),
        .init(iconSystemName: "cart.badge.plus", buttonName: "Venta", buttonColor: Color.green)
    ]
    
    ///Layout de los butones
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 30) {
                Text("Farmapunto")
                    .font(.system(size: 50))
                    .bold()
                    .padding()
                
                HStack(spacing: 30) {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(buttonConfigs, id: \.buttonName) { squareOption in
                            squareButton(iconSystemName: squareOption.iconSystemName,
                                         buttonName: squareOption.buttonName,
                                         buttonColor: squareOption.buttonColor)
                            .onTapGesture {
                                path.append(squareOption.buttonName) // Navega a la vista de inventario
                            }
                        }
                    }
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                            case "Productos":
                                ProductTabView(path: $path)
                            case "Inventario":
                                InventoryTabView()
                            case "Mantenedor Precios":
                                PriceMantainerTabView()
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
        .modelContainer(for: [Product.self, Inventory.self, Transaction.self], inMemory: true)
}
