//
//  CoreDataManager.swift
//  CoreData-GettingStarted
//
//  Created by Glenn Ludszuweit on 27/04/2023.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: CoreDataProtocol {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveData(data: [Pokemon]) throws {
        try deleteData()
        data.forEach { pokemon in
            let pokeEntity = PokemonEntity(context: context)
            pokeEntity.id = pokemon.id
            pokeEntity.name = pokemon.name
            
            let pokeImgEntity = ImagesEntity(context: context)
            pokeImgEntity.small = pokemon.images.small
            pokeImgEntity.large = pokemon.images.large
            
            pokeEntity.images = pokeImgEntity
        }
        do {
            try context.save()
        } catch let error {
            throw error
        }
    }
    
    func getData(entity: NSManagedObject.Type) throws -> [NSFetchRequestResult] {
        let fetchDataRequest = entity.fetchRequest()
        do {
            let data = try context.fetch(fetchDataRequest)
            return data
        } catch let error {
            throw error
        }
    }
    
    private func deleteData() throws {
        let pokeData = try getData(entity: PokemonEntity.self)
        let pokeImgsData = try getData(entity: ImagesEntity.self)
        
        pokeData.forEach{ item in
            context.delete(item as! NSManagedObject)
        }
        pokeImgsData.forEach{ item in
            context.delete(item as! NSManagedObject)
        }
        do {
            try context.save()
            print("Database cleared")
        } catch let error {
            throw error
        }
        
    }
}
