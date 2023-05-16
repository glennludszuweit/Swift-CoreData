import Foundation

// MARK: - Welcome
struct PokemonData: Codable {
    let data: [Pokemon]
    let page, pageSize, count, totalCount: Int
}

// MARK: - Datum
struct Pokemon: Codable, Identifiable, Hashable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: String
    let name: String
    let images: Images
}

// MARK: - DatumImages
struct Images: Codable {
    let small, large: String?
}


