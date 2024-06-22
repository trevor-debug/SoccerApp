import SwiftUI

struct EditMatchView: View {
    @State var matchDate: Date
    @State var opponent: String
    @State var home: Bool
    @State var result: String?

    var onSave: ((Match) -> Void)? // Callback to save the match

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $matchDate, displayedComponents: .date)
                
                TextField("Opponent", text: $opponent)
                
                Toggle("Home Match", isOn: $home)
                
                if let resultBinding = $result.unwrap() {
                    TextField("Result", text: resultBinding)
                } else {
                    TextField("Result", text: .constant(""))
                }
            }
            .navigationTitle("Edit Match")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Dismiss the view
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newMatch = Match(id: UUID(), date: matchDate, opponent: opponent, home: home, result: result)
                        onSave?(newMatch)
                        // Dismiss the view
                    }
                }
            }
        }
    }
}

struct EditMatchView_Previews: PreviewProvider {
    static var previews: some View {
        EditMatchView(matchDate: Date(), opponent: "Sample Opponent", home: true, result: nil)
    }
}
