//
//  Item.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
