import SwiftUI

struct MatchDetailView: View {
    var match: Match

    var body: some View {
        VStack {
            Text("Date: \(match.date, style: .date)")
                .font(.headline)
                .padding()

            Text("Opponent: \(match.opponent)")
                .font(.title)
                .padding()

            Text("Home Match: \(match.home ? "Yes" : "No")")
                .font(.subheadline)
                .padding()

            if let result = match.result {
                Text("Result: \(result)")
                    .font(.subheadline)
                    .padding()
            } else {
                Text("Result: N/A")
                    .font(.subheadline)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Match Details")
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(match: Match(id: UUID(), date: Date(), opponent: "Sample Opponent", home: true, result: "Win"))
    }
}
