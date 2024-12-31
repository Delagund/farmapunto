//  Created by Cristián Ortiz on 31-12-24.
// Botones del menú principal

import SwiftUI

struct squareButton: View {
        var iconSystemName: String = ""
        var buttonName: String = ""
        var buttonColor: Color = .blue
        
        var body: some View {
            VStack {
                Image(systemName: iconSystemName) // reemplazar por iconSystemName
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(buttonName) // reemplazar por buttonName
                    .bold()
            }
            .frame(width: 150, height: 150)
            .background(buttonColor.opacity(0.1)) // reemplazar por buttonColor
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 5)
                    .foregroundColor(buttonColor) // reemplazar por buttonColor
            }
        }
    }
