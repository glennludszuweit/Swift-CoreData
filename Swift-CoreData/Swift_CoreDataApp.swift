//
//  Swift_CoreDataApp.swift
//  Swift-CoreData
//
//  Created by Glenn Ludszuweit on 16/05/2023.
//

import SwiftUI

@main
struct Swift_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PokemonGalleryView(pokemonViewModel: PokemonViewModel(networkManager: NetworkManager()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
