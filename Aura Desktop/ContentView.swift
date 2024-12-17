import SwiftUI

struct ContentView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 300

    var body: some View {
        ZStack {
            // Background
            Color.blue.opacity(0.3) // Simulating a cold, winter sky

            // Snowflakes
            ForEach(snowflakes) { snowflake in
                Circle()
                    .frame(width: snowflake.size, height: snowflake.size)
                    .foregroundColor(.white)
                    .position(x: snowflake.x, y: snowflake.y)
            }
        }
        .onAppear {
            // Start generating snowflakes
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                addSnowflake()
            }
            
            // Animate snowflakes
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                moveSnowflakes()
            }
        }
    }

    // Add a new snowflake
    func addSnowflake() {
        guard snowflakes.count < maxSnowflakes else { return }
        
        let snowflake = Snowflake(
            id: UUID(),
            x: CGFloat.random(in: 0...800), // Adjust width to window size
            y: -10,
            size: CGFloat.random(in: 5...15),
            speed: CGFloat.random(in: 1...5)
        )
        snowflakes.append(snowflake)
    }

    // Move snowflakes downward
    func moveSnowflakes() {
        snowflakes = snowflakes.map { snowflake in
            var newSnowflake = snowflake
            newSnowflake.x += CGFloat.random(in: -2...2) // Simulate wind
            newSnowflake.y += snowflake.speed
            return newSnowflake
        }

        // Remove snowflakes that are off-screen
        snowflakes = snowflakes.filter { $0.y < 600 }
    }
}

struct Snowflake: Identifiable {
    let id: UUID
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
