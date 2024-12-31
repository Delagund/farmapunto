//
//  PlaceHolderView.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 27-12-24.
//

import SwiftUI

struct PlaceHolderView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
    }
}

#Preview {
    let title = "prueba"
    PlaceHolderView(title: title)
}
