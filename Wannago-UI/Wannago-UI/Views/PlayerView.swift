import SwiftUI

struct PlayerView: View {
    let player: Player
    let position: CGPoint
    let color: Color
    
    @Binding var allPlayerNames: [String: CGPoint] // Binding to track all player names and positions
    
    var body: some View {
        VStack {
            if allPlayerNames.filter({ $0.value == position }).count > 1 {
                Text(player.name)
                    .font(.caption)
            } else {
                Text(player.name.prefix(1))
                    .font(.headline)
            }
        }
        .frame(width: 50, height: 50)
        .background(color)
        .foregroundColor(.white)
        .clipShape(Circle())
        .position(position)
    }
}
