// Sample data for container in preview

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Product.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for product in SampleProducts.contents {
            container.mainContext.insert(product)
        }
        return container
    } catch {
        fatalError("Error en cargar Sample Data")
    }
}()
