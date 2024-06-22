import Foundation

struct Team: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var coachName: String
    var players: [Player]
    var formation: Formation
}
