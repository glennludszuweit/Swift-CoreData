//
//  CoreDataProtocol.swift
//  CoreData-GettingStarted
//
//  Created by Glenn Ludszuweit on 27/04/2023.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    func saveData(data: [Pokemon]) throws
    func getData(entity: NSManagedObject.Type) throws -> [NSFetchRequestResult]
}
