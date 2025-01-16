//  Created by Cristián Ortiz on 31-12-24.
// Botones del menú principal

import SwiftUI

struct squareButton: View {
        var iconSystemName: String = ""
        var buttonName: String = ""
        var buttonColor: Color = .blue
        
        var body: some View {
            VStack(alignment: .center) {
                Image(systemName: iconSystemName) //ícono de cada boton principal
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                Text(buttonName) // nombre en pantalla
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(buttonColor) //color del texto
            }
            .foregroundStyle(buttonColor) //color del texto
            .frame(width: 150, height: 150)
            //.background(buttonColor.opacity(0.1)) // color del fondo del boton
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 6)
                    .foregroundColor(buttonColor) // color del borde
            }
        }
    }
