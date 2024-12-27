//
//  SelectionMenuView.swift
//  ERP2Alpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI

struct MainMenuApp: View {
    
    @State private var path = NavigationPath() // Ruta global
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 30) {
                Text("Farmapunto")
                    .font(.system(size: 50))
                    .bold()
                    .padding()
                
                HStack(spacing: 30) {
                    
                    VStack {
                        Image(systemName: "pills.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Productos")
                            .bold()
                    }
                    .frame(width: 150, height: 150)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.blue)
                    }
                    .onTapGesture {
                        path.append("Productos") // Navega a la vista de productos
                    }
                    
                    VStack {
                        Image(systemName: "pencil.and.list.clipboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Inventario")
                            .bold()
                    }
                    .frame(width: 150, height: 150)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        path.append("Inventario") // Navega a la vista de inventario
                    }
                    
                    
                }
                
                HStack(spacing: 30){
                    VStack(alignment: .center) {
                        Image(systemName: "dollarsign.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Mantenedor Precios")
                            .bold()
                    }
                    .frame(width: 150, height: 150)
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.yellow)
                    }
                    .onTapGesture {
                        path.append("Precios") // Navega a la vista de Mantenedor de Precios
                    }
                    
                    VStack(alignment: .center) {
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Punto de Venta")
                            .bold()
                    }
                    .frame(width: 150, height: 150)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.green)
                    }
                }
                .navigationDestination(for: String.self) { destination in
                    if destination == "Productos" {
                        ProductTabView()
                    } else if destination == "Inventario" {
                        InventoryTabView()
                    } else if destination == "Precios" {
                        PriceMantainerTabView()
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainMenuApp()
        .modelContainer(for: Product.self, inMemory: true)
}
