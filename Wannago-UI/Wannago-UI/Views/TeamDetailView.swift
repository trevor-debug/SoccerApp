import SwiftUI

struct TeamDetailView: View {
    var team: Team

    var body: some View {
        VStack {
            Text("Coach: \(team.coachName)")
                .font(.headline)
            
            List(team.players) { player in
                NavigationLink(destination: PlayerDetailView(player: player)) {
                    Text("\(player.name) - \(player.position)")
                }
            }
            
            Text("Formation: \(team.formation.name)")
                .font(.subheadline)
            
            HStack {
                ForEach(team.formation.positions, id: \.self) { position in
                    Text(position)
                        .padding()
                }
            }
            
            NavigationLink(destination: TacticsBoardView(team: team)) {
                Text("Open Tactics Board")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: TeamStatisticsView(team: team)) {
                Text("View Statistics")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle(team.name)
        .padding()
    }
}
