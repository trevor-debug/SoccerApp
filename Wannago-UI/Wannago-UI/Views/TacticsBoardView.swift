import SwiftUI

struct TacticsBoardView: View {
    @State private var playerPositions: [UUID: CGPoint] = [:]
    @State private var drawingPaths: [DrawingPath] = []
    @State private var currentDrawingPath: DrawingPath = DrawingPath(points: [])
    @State private var isDrawing: Bool = false
    @State private var allPlayerNames: [String: CGPoint] = [:] // To track all player names and positions
    @State private var ballPosition: CGPoint = CGPoint(x: 150, y: 300) // Initial position of the ball

    let team: Team
    @State private var opposingTeam: [Player]
    
    init(team: Team) {
        self.team = team
        _opposingTeam = State(initialValue: Self.createPresetOpposingTeam())
        
        // Load saved player positions
        if let savedPlayerPositions = UserDefaults.standard.data(forKey: "savedPlayerPositions"),
           let decodedPositions = try? JSONDecoder().decode([UUID: CGPoint].self, from: savedPlayerPositions) {
            _playerPositions = State(initialValue: decodedPositions)
        }
        
        // Load saved drawing paths
        if let savedDrawingPaths = UserDefaults.standard.data(forKey: "savedDrawingPaths"),
           let decodedPaths = try? JSONDecoder().decode([DrawingPath].self, from: savedDrawingPaths) {
            _drawingPaths = State(initialValue: decodedPaths)
        }

        // Load saved ball position
        if let savedBallPosition = UserDefaults.standard.data(forKey: "savedBallPosition"),
           let decodedPosition = try? JSONDecoder().decode(CGPoint.self, from: savedBallPosition) {
            _ballPosition = State(initialValue: decodedPosition)
        }
    }
    
    static func createPresetOpposingTeam() -> [Player] {
        let positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"]
        var players = (1...9).map { i in
            Player(id: UUID(), name: "Opp \(i)", position: positions[i % 4])
        }
        players.append(Player(id: UUID(), name: "Bench 1", position: "Bench"))
        players.append(Player(id: UUID(), name: "Bench 2", position: "Bench"))
        return players
    }
    
    static func presetPositions() -> [UUID: CGPoint] {
        var positions: [UUID: CGPoint] = [:]
        positions[UUID()] = CGPoint(x: 150, y: 50) // Goalkeeper
        positions[UUID()] = CGPoint(x: 100, y: 150) // Defender 1
        positions[UUID()] = CGPoint(x: 200, y: 150) // Defender 2
        positions[UUID()] = CGPoint(x: 150, y: 250) // Defender 3
        positions[UUID()] = CGPoint(x: 100, y: 350) // Midfielder 1
        positions[UUID()] = CGPoint(x: 200, y: 350) // Midfielder 2
        positions[UUID()] = CGPoint(x: 50, y: 450)  // Forward 1
        positions[UUID()] = CGPoint(x: 150, y: 450) // Forward 2
        positions[UUID()] = CGPoint(x: 250, y: 450) // Forward 3
        positions[UUID()] = CGPoint(x: 50, y: 550)  // Bench 1
        positions[UUID()] = CGPoint(x: 250, y: 550) // Bench 2
        return positions
    }
    
    var body: some View {
        ZStack {
            Image("soccer_field") // Background image of the soccer field
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Path { path in
                        for drawingPath in drawingPaths {
                            path.addLines(drawingPath.points)
                        }
                    }
                    .stroke(Color.red, lineWidth: 2)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if isDrawing {
                                currentDrawingPath.points.append(value.location)
                            }
                        }
                        .onEnded { _ in
                            if isDrawing {
                                drawingPaths.append(currentDrawingPath)
                                currentDrawingPath = DrawingPath(points: [])
                            }
                        }
                )
            
            // Player views for the main team
            ForEach(team.players) { player in
                PlayerView(player: player, position: playerPositions[player.id, default: CGPoint(x: 100, y: 100)], color: .blue, allPlayerNames: $allPlayerNames)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                playerPositions[player.id] = value.location
                                allPlayerNames[player.name] = value.location
                            }
                    )
            }
            
            // Player views for the opposing team
            ForEach(opposingTeam) { player in
                PlayerView(player: player, position: playerPositions[player.id, default: TacticsBoardView.presetPositions()[player.id, default: CGPoint(x: 300, y: 300)]], color: .red, allPlayerNames: $allPlayerNames)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                playerPositions[player.id] = value.location
                                allPlayerNames[player.name] = value.location
                            }
                    )
            }
            
            // Ball view
            Circle()
                .fill(Color.orange)
                .frame(width: 20, height: 20)
                .position(ballPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            ballPosition = value.location
                        }
                )
        }
        .padding()
        .navigationTitle("Tactics Board")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isDrawing.toggle()
                }) {
                    Text(isDrawing ? "Stop Drawing" : "Start Drawing")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if !drawingPaths.isEmpty {
                        drawingPaths.removeLast()
                    }
                }) {
                    Text("Undo")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    drawingPaths.removeAll()
                }) {
                    Text("Clear All")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveTactics()
                }) {
                    Text("Save")
                }
            }
        }
    }
    
    func saveTactics() {
        // Save the playerPositions and drawingPaths
        // This can be to UserDefaults, a file, or any other persistent storage
        // For simplicity, here is an example of saving to UserDefaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerPositions) {
            UserDefaults.standard.set(encoded, forKey: "savedPlayerPositions")
        }
        if let encoded = try? encoder.encode(drawingPaths) {
            UserDefaults.standard.set(encoded, forKey: "savedDrawingPaths")
        }
        if let encoded = try? encoder.encode(ballPosition) {
            UserDefaults.standard.set(encoded, forKey: "savedBallPosition")
        }
    }
}
