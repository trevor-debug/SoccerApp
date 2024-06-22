import SwiftUI

struct EditTeamView: View {
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    @State var teamName: String
    @State var coachName: String
    @State var players: [Player]
    @State var formation: Formation

    var onSave: ((Team) -> Void)? // Callback to save the team
    
    let positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Team Details")) {
                    TextField("Team Name", text: $teamName)
                    TextField("Coach Name", text: $coachName)
                }
                
                Section(header: Text("Players")) {
                    ForEach(players.indices, id: \.self) { index in
                        NavigationLink(destination: EditPlayerView(
                            playerName: players[index].name,
                            playerPosition: players[index].position,
                            imageUrl: players[index].imageUrl) { updatedPlayer in
                                players[index] = updatedPlayer
                            }) {
                            Text(players[index].name)
                        }
                    }
                    Button(action: {
                        players.append(Player(id: UUID(), name: "", position: positions.first!, imageUrl: nil))
                    }) {
                        Text("Add Player")
                    }
                }
                
                Section(header: Text("Formation")) {
                    TextField("Formation Name", text: $formation.name)
                    ForEach(formation.positions.indices, id: \.self) { index in
                        Picker("Position", selection: $formation.positions[index]) {
                            ForEach(positions, id: \.self) { position in
                                Text(position).tag(position)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Button(action: {
                        formation.positions.append(positions.first!)
                    }) {
                        Text("Add Position")
                    }
                }
            }
            .navigationTitle("Edit Team")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newTeam = Team(id: UUID(), name: teamName, coachName: coachName, players: players, formation: formation)
                        onSave?(newTeam)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct EditTeamView_Previews: PreviewProvider {
    static var previews: some View {
        EditTeamView(teamName: "Sample Team", coachName: "Sample Coach", players: [], formation: Formation(name: "", positions: []))
    }
}
