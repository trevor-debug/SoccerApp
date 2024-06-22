import SwiftUI

struct PlayerDetailView: View {
    let player: Player

    var body: some View {
        VStack {
            if let imageUrl = player.imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 100, height: 100)
                         .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }

            Text(player.name)
                .font(.largeTitle)
                .padding()

            Text("Position: \(player.position)")
                .font(.title2)
                .padding()

            // Add more player details here

            Spacer()
        }
        .navigationTitle("Player Details")
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: Player(id: UUID(), name: "Sample Player", position: "Forward", imageUrl: nil))
    }
}
