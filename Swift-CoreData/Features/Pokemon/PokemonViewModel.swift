//
//  PokemonViewModel.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var customError: ErrorHandler?
    
    var networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func getAll(_ urlString: String = API.pokemonCardsApi, context: NSManagedObjectContext) async {
        guard let url = URL(string: urlString) else {
            customError = ErrorHandler.invalidUrlError
            return
        }
        do {
            let result = try await self.networkManager.getAll(apiURL: url)
            let pokemondData = try JSONDecoder().decode(PokemonData.self, from: result)
            self.pokemons = pokemondData.data
            
            let coreDataManager = CoreDataManager(context: context)
            try coreDataManager.saveData(data: self.pokemons)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
}
