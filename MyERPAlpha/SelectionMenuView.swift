//
//  SelectionMenuView.swift
//  ERP2Alpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI

struct SelectionMenuView: View {

    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "pill.fill")
                    Text("Productos")
                }
        }
    }
}

#Preview {
    SelectionMenuView()
}
