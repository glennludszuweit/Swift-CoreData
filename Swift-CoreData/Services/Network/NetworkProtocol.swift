//
//  NetworkProtocol.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import Foundation

protocol NetworkProtocol {
    func getAll(apiURL: URL) async throws -> Data
}
