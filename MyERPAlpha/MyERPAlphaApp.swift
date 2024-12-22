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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true) //TODO: cambiar a false para que exista persistencia de datos

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
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
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
