//
//  PointOfSaleView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 21-12-24.
//

import SwiftUI

struct PointOfSaleView: View {
    @State private var products: [Product] = [
        Product(name: "PARACETAMOL 500MG X 30 COMP", price: 100, quantity: 1, sku: "1234567890123"),
        Product(name: "IBUPROFENO 600MG X 20 COMP", price: 200, quantity: 1, sku: "123456"),
        Product(name: "Kitadol Jarabe x 120 ML", price: 300, quantity: 1, sku: "123456"),
        Product(name: "CLORFENAMINA 4 MG X 20 COMP", price: 2400, quantity: 2, sku: "123456")
    ]
    @State private var searchText: String = ""
    @State private var cashMoney: Double = 0.0
    
    // variables calculadas para las operaciones matematicas del POS
    var vuelto: Double {
        let result = cashMoney - total
        if result <= 0 { return 0.0
        } else {
            return result
        }
    }
    
    var subtotal: Double {
        products.reduce(0) {$0 + ($1.price * Double($1.quantity)) - (($1.price * Double($1.quantity) * 0.19))}
    }
    
    var fee: Double {
        products.reduce(0) {$0 + (($1.price * Double($1.quantity) * 0.19))} // 19% de impuesto
    }
    
    var total: Double {
        products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var itemsQty: Int {
        products.reduce(0) { $0 + $1.quantity }
    }
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity), alignment: .leading)
        
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                // Título de la vista
                Text("Punto de Venta")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                // Informacion de número de transacion y fecha
                HStack{
                    Text("Venta Nº: 123")
                    Spacer()
                    Text("Fecha: 23/12/2024")
                }
                .padding(.horizontal)
                
                // Barra de búsqueda para agregar productos
                HStack(spacing: 0) {
                    TextField("Nombre o código del producto", text: $searchText)
                        .padding(10)
                        .background(Color.gray.opacity(0.3))
                    //.clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            products.append(Product(name: searchText, price: 0.0, quantity: 1, sku: ""))
                            searchText = ""
                        }
                    }) {
                        Text("Agregar")
                            .padding(11)
                            .background(.black)
                            .foregroundStyle(.white)
                        // .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                
                Divider()
                // Encabezados de las columnas
                
                LazyVGrid(columns: columns) {
                    Text("Producto").bold()
                    Text("Precio").bold()
                    Text("Cantidad").bold()
                }
                .frame(maxWidth: .infinity)
                
                
                
                // Filas dinámicas
                ForEach(products.indices, id: \.self) { index in
                    Grid(horizontalSpacing: 5) {
                        GridRow {
                            // Primera fila: Producto, Cantidad y Precio
                            // Producto
                            Text(products[index].name)
                                .lineLimit(2)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.leading)
                                .gridColumnAlignment(.leading)
                                .frame(width: 140, alignment: .leading)
                            
                            // Precio unitario
                            Text("$\(String(format: "%.0f", products[index].price))")
                                .frame(width: 90)
                            
                            // Cantidad
                            Stepper("\(products[index].quantity)", value: $products[index].quantity, in: 1...99)
                                .bold()
                                .frame(width: 140)
                        }
                        // Segunda fila: Subtotal
                        GridRow {
                            // SKU
                            Text("SKU: \(products[index].sku)")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                            
                            //Subtotal
                            HStack(spacing: 15) {
                                Text("Subtotal:")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16, design: .rounded))
                                Text("$\(String(format: "%.0f", products[index].price * Double(products[index].quantity)))")
                                
                                // Botón de eliminación
                                Button(action: {
                                    products.remove(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .gridCellColumns(2)
                            .gridCellAnchor(UnitPoint(x: 0.9, y: 0.75))
                            
                            
                        }
                        
                        GridRow {
                            Divider()
                                .gridCellColumns(3)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Resumen de Totales
                VStack(alignment: .trailing, spacing: 10) {
                    HStack(alignment: .center){
                        HStack{
                            Text("Items:")
                            Text("\(itemsQty) un.")
                        }
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.secondary)
                        Spacer()
                        HStack {
                            Text("Total:")
                            Text("$\(String(format: "%.0f", total))")
                        }
                        .font(.system(size: 25, design: .rounded))
                        .bold()
                    }
                    HStack {
                        Spacer()
                        Text("IVA en esta compra (19%):")
                        Text("$\(String(format: "%.0f", fee))")
                    }
                    .font(.system(size: 15, design: .rounded))
                    .foregroundStyle(.secondary)
                    
                    HStack(alignment: .lastTextBaseline) {
                        Text("Efectivo: ")
                        TextField("Valor", value: $cashMoney, format: .number)
                            .frame(width: 70)
                            .background(Color.gray.opacity(0.3))
                            .padding(5)
                        Text("Vuelto: $\(String(format: "%.0f", vuelto))")
                    }
                    .fontWeight(.medium)
                }
                .padding()
                
                // Botones de acción
                HStack {
                    // Botón "Cancelar"
                    Button(action: {
                        // Implementar lógica de "cancelar" aquí
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
                        // Implementar lógica de "terminar venta" aquí
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
}

#Preview {
    PointOfSaleView()
}
