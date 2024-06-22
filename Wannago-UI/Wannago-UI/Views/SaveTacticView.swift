import SwiftUI

struct SaveTacticView: View {
    @State private var tacticName: String = ""
    var onSave: ((String) -> Void)?

    var body: some View {
        NavigationView {
            Form {
                TextField("Tactic Name", text: $tacticName)
            }
            .navigationTitle("Save Tactic")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Dismiss the view
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave?(tacticName)
                        // Dismiss the view
                    }
                }
            }
        }
    }
}

struct SaveTacticView_Previews: PreviewProvider {
    static var previews: some View {
        SaveTacticView()
    }
}
