import SwiftUI

struct MatchListView: View {
    @State private var matches: [Match] = []
    @State private var showingEditMatchView = false
    @State private var editingMatch: Match? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(matches) { match in
                    HStack {
                        Text(match.opponent)
                        Spacer()
                        Text(match.date, style: .date)
                    }
                    .contextMenu {
                        Button {
                            self.editingMatch = match
                            self.showingEditMatchView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        Button(role: .destructive) {
                            if let index = matches.firstIndex(of: match) {
                                matches.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Matches")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingMatch = nil
                        showingEditMatchView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingEditMatchView) {
                if let editingMatch = editingMatch {
                    EditMatchView(
                        matchDate: editingMatch.date,
                        opponent: editingMatch.opponent,
                        home: editingMatch.home,
                        result: editingMatch.result
                    ) { updatedMatch in
                        if let index = matches.firstIndex(where: { $0.id == editingMatch.id }) {
                            matches[index] = updatedMatch
                        }
                        showingEditMatchView = false
                    }
                } else {
                    EditMatchView(
                        matchDate: Date(),
                        opponent: "",
                        home: true,
                        result: nil
                    ) { newMatch in
                        matches.append(newMatch)
                        showingEditMatchView = false
                    }
                }
            }
        }
    }
}

struct MatchListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView()
    }
}
