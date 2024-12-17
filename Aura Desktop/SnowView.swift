import SwiftUI

struct SnowView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 300
    let angle: Double = 30.0
    let color: Color = Color(.white)

    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)

            Canvas { context, size in
                for snowflake in snowflakes {
                    let rect = CGRect(
                        x: snowflake.x,
                        y: snowflake.y,
                        width: snowflake.size,
                        height: snowflake.size
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(color))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            initializeSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }

    func initializeSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        snowflakes = (0...maxSnowflakes).map { _ in
            Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...maxX),
                y: -1*CGFloat.random(in: 0...1000),
                size: CGFloat.random(in: 5...13),
                speed: CGFloat.random(in: 1...3)
            )
        }
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed
            if angle != 0.0 {
                snowflakes[i].x -= tan(90 - angle)*snowflakes[i].speed
            }
            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].y = -10
                snowflakes[i].speed = CGFloat.random(in: 1...3)
                snowflakes[i].x = CGFloat.random(in: 0...maxX)
            }
        }
    }
}
