import SwiftUI

struct TeamStatisticsView: View {
    var team: Team

    var body: some View {
        VStack {
            Text("Team Statistics")
                .font(.largeTitle)
                .padding()

            // Placeholder for team statistics
            Text("Matches Played: 10")
            Text("Wins: 7")
            Text("Losses: 3")
            Text("Goals Scored: 20")
            Text("Goals Conceded: 10")

            // Add more detailed statistics here

            Spacer()
        }
        .navigationTitle("Statistics")
    }
}

struct TeamStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamStatisticsView(team: Team(id: UUID(), name: "Sample Team", coachName: "Sample Coach", players: [], formation: Formation(name: "", positions: [])))
    }
}
