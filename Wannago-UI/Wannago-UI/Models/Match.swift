import Foundation

struct Match: Identifiable, Codable, Hashable {
    let id: UUID
    var date: Date
    var opponent: String
    var home: Bool
    var result: String? // Optional for tracking the result
}
