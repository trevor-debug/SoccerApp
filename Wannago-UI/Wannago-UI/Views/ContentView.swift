import SwiftUI

struct ContentView: View {
    @State private var teams: [Team] = [
        Team(id: UUID(), name: "Dream Team", coachName: "Alex Ferguson", players: [
            Player(id: UUID(), name: "Player 1", position: "Forward"),
            Player(id: UUID(), name: "Player 2", position: "Midfielder")
        ], formation: Formation(name: "4-4-2", positions: ["Forward", "Midfielder", "Defender", "Goalkeeper"]))
    ]
    @State private var showingEditTeamView = false
    @State private var editingTeam: Team? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(teams) { team in
                    NavigationLink(destination: TeamDetailView(team: team)) {
                        Text(team.name)
                    }
                    .swipeActions {
                        Button {
                            self.editingTeam = team
                            self.showingEditTeamView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                        
                        Button(role: .destructive) {
                            if let index = teams.firstIndex(of: team) {
                                teams.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Teams")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingTeam = nil
                        showingEditTeamView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingEditTeamView) {
                if let editingTeam = editingTeam {
                    EditTeamView(
                        teamName: editingTeam.name,
                        coachName: editingTeam.coachName,
                        players: editingTeam.players,
                        formation: editingTeam.formation
                    ) { updatedTeam in
                        if let index = teams.firstIndex(where: { $0.id == editingTeam.id }) {
                            teams[index] = updatedTeam
                        }
                        showingEditTeamView = false
                    }
                } else {
                    EditTeamView(
                        teamName: "",
                        coachName: "",
                        players: [],
                        formation: Formation(name: "", positions: [])
                    ) { newTeam in
                        teams.append(newTeam)
                        showingEditTeamView = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
