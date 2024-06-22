import Foundation

struct Player: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var position: String
    var imageUrl: URL?
}
