//  Created by Cristián Ortiz on 31-12-24.
// Botones del menú principal

import SwiftUI

struct SquareButton: View {
    var iconSystemName: String = ""
    var buttonName: String = ""
    var buttonColor: Color = .blue
    // Valores para los frame del boton.
    let frameSizeA: CGFloat = 55
    let frameSizeB: CGFloat = 150
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: iconSystemName) //ícono de cada boton principal
                .resizable()
                .scaledToFit()
                .frame(width: frameSizeA, height: frameSizeA)
            Text(buttonName) // nombre en pantalla
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(buttonColor) //color del texto
        }
        .foregroundStyle(buttonColor) //color del texto
        .frame(width: frameSizeB, height: frameSizeB)
        //.background(buttonColor.opacity(0.1)) // color del fondo del boton
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 6)
                .foregroundColor(buttonColor) // color del borde
        }
    }
}

#Preview {
    let iconSystemName = "pencil"
    let buttonName = "Name"
    SquareButton(iconSystemName: iconSystemName, buttonName: buttonName)
}

