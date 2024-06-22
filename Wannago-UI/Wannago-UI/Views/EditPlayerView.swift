import SwiftUI

struct EditPlayerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var playerName: String
    @State var playerPosition: String
    @State var imageUrl: URL?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"]
    var onSave: ((Player) -> Void)?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player Details")) {
                    TextField("Player Name", text: $playerName)
                    Picker("Position", selection: $playerPosition) {
                        ForEach(positions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                Section(header: Text("Player Image")) {
                    if let imageUrl = imageUrl, let data = try? Data(contentsOf: imageUrl), let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    }
                }
            }
            .navigationTitle("Edit Player")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newPlayer = Player(id: UUID(), name: playerName, position: playerPosition, imageUrl: imageUrl)
                        onSave?(newPlayer)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        guard let data = inputImage.jpegData(compressionQuality: 0.8) else { return }
        let filename = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        try? data.write(to: filename)
        imageUrl = filename
    }
}

struct EditPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlayerView(playerName: "Sample Player", playerPosition: "Forward")
    }
}
