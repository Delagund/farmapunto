//
//  MyERPAlphaApp.swift
//  MyERPAlpha
//
//  Created by Cristián Ortiz on 13-12-24.
//

import SwiftUI
import SwiftData

@main
struct MyERPAlphaApp: App {
    /// Esquema para almacenamiento de datos
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self,
            Inventory.self,
            Price.self,
            InventoryMovement.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true) //TODO: cambiar a false para que exista persistencia de datos

        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            print("Could not create ModelContainer: \(error)")
            fatalError()
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainMenuApp()
        }
        .modelContainer(sharedModelContainer)
    }
    /// Dirección de arhcivo de base de datos.
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
