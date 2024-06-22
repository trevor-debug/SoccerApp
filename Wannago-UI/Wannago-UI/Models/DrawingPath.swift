import Foundation
import CoreGraphics

struct DrawingPath: Identifiable, Codable {
    let id = UUID()
    var points: [CGPoint]
}
