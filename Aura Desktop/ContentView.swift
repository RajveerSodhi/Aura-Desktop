import SwiftUI

struct Snowflake: Identifiable {
    let id: UUID
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
}

struct ContentView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 300

    var body: some View {
        ZStack {
            // Light blue background to simulate a cold sky
            Color.blue.opacity(0.1)

            // Use Canvas to efficiently draw multiple snowflakes
            Canvas { context, size in
                for snowflake in snowflakes {
                    let rect = CGRect(
                        x: snowflake.x,
                        y: snowflake.y,
                        width: snowflake.size,
                        height: snowflake.size
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(.white))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            // Periodically add snowflakes until we reach our limit
            Timer.scheduledTimer(withTimeInterval: 0.45, repeats: true) { _ in
                addSnowflake(screenSize: NSScreen.main?.frame.size ?? .zero)
            }

            // Update snowflake positions at ~60 fps
            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }

    func addSnowflake(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        guard snowflakes.count < maxSnowflakes else { return }

        let snowflake = Snowflake(
            id: UUID(),
            x: CGFloat.random(in: 0...screenSize.width),
            y: -10, // Start above the top of the screen
            size: CGFloat.random(in: 5...13),
            speed: CGFloat.random(in: 1...3)
        )
        snowflakes.append(snowflake)
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed

            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].y = -10
                snowflakes[i].x = CGFloat.random(in: 0...screenSize.width)
            }
        }
    }
}
